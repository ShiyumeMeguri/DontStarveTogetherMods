
local MakePlayerCharacter = require "prefabs/player_common"


local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}
local prefabs = {}

local start_inv = {
}

local function onbecamehuman(inst)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "ria_speed_mod", 1)
end

local function onbecameghost(inst)
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "ria_speed_mod")
end

local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end


local common_postinit = function(inst)
	inst.MiniMapEntity:SetIcon( "ria.tex" )
end

local master_postinit = function(inst)
	inst.soundsname = "willow"
	
	inst.components.health:SetMaxHealth(120)
	inst.components.hunger:SetMax(100)
	inst.components.sanity:SetMax(300)
	
	inst:ListenForEvent("attacked", onAttacked)
	
	inst.components.sanity.neg_aura_mult = 0.2
	inst.components.health.fire_damage_scale = 0.4
	inst.components.builder.science_bonus = 2
	
    inst.components.combat.damagemultiplier = 1.2
	
	inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE
	
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
	
end

return MakePlayerCharacter("ria", prefabs, assets, common_postinit, master_postinit, start_inv)
