
local MakePlayerCharacter = require "prefabs/player_common"


local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}
local prefabs = {}

-- Custom starting items
local start_inv = {
"omelet",
"caver",
"wf",
"ammo",
"ammo",
"ammo",
"ammo",
"ammo",
"ammo",
}


local function applyupgrades(inst)

	local max_upgrades = 50
	local upgrades = math.min(inst.level, max_upgrades)

	local hunger_percent = inst.components.hunger:GetPercent()
	local health_percent = inst.components.health:GetPercent()
	local sanity_percent = inst.components.sanity:GetPercent()

	inst.components.hunger.max = math.ceil (100 + upgrades * 1.5) --175
	inst.components.health.maxhealth = math.ceil (120 + upgrades * 2) --220
	inst.components.sanity.max = math.ceil (145 + upgrades * 2) --245
	
	
	inst.components.hunger:SetPercent(hunger_percent)
	inst.components.health:SetPercent(health_percent)
	inst.components.sanity:SetPercent(sanity_percent)
	
end

local function oneat(inst, food)
	if food and food.components.edible and food.prefab == "omelet"or food.prefab == "monstermeat" then
		inst.level = inst.level + 1
		applyupgrades(inst)	
		inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/levelup")
	end
end

local function onpreload(inst, data)
	if data then
		if data.level then
			inst.level = data.level
			applyupgrades(inst)
			if data.health and data.health.health then inst.components.health.currenthealth = data.health.health end
			if data.hunger and data.hunger.hunger then inst.components.hunger.current = data.hunger.hunger end
			if data.sanity and data.sanity.current then inst.components.sanity.current = data.sanity.current end
			inst.components.health:DoDelta(0)
			inst.components.hunger:DoDelta(0)
			inst.components.sanity:DoDelta(0)
		end
	end
end

local function onsave(inst, data)
	data.level = inst.level
	data.charge_time = inst.charge_time
end

local function onbecamehuman(inst)
	inst.components.locomotor.walkspeed = 6
	inst.components.locomotor.runspeed = 8
end


local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
	
    if not inst:HasTag("playerghost") then
        onbecamehuman(inst)
    end
end



-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "ange.tex" )
	inst.soundsname = "willow"
	inst:AddTag("ange")
	inst:AddTag("ange_builder")
	inst:AddTag("speciallickingowner")
end

-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	
	inst.level = 0
	inst.components.eater:SetOnEatFn(oneat)
	applyupgrades(inst)
	
	inst:AddComponent("reader")	
    inst:AddComponent("leader")
    inst:AddComponent("knownlocations")
	
	inst.components.health:SetMaxHealth(100)
	inst.components.hunger:SetMax(120)
	inst.components.sanity:SetMax(150)
	
	inst.components.locomotor.walkspeed = 6
	inst.components.locomotor.runspeed = 8
	inst.components.combat.damagemultiplier = 1.00
	inst.components.hunger.hungerrate = (TUNING.WILSON_HUNGER_RATE * 1.00)

	inst.components.builder.science_bonus = 1
	inst.components.builder.magic_bonus = 2
	
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
	
end

return MakePlayerCharacter("ange", prefabs, assets, common_postinit, master_postinit, start_inv)
