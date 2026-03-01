local MakePlayerCharacter = require "prefabs/player_common"
return MakePlayerCharacter("sora", {}, {}, 
function(inst) 
	inst.MiniMapEntity:SetIcon( "sora.tex" )
	inst:AddTag("sora_build")
	inst.soundsname = "willow"
	inst:AddComponent("keyhandler")
    inst.components.keyhandler:AddActionListener("sora", TUNING.TENSHIKEY, "TENSHIMODE")
    inst.components.keyhandler:AddActionListener("sora", TUNING.NEBOUKEY, "NEBOU")
end, 
function(inst)
	inst.components.health:SetMaxHealth(100)
	inst.components.hunger:SetMax(80)
	inst.components.sanity:SetMax(80)
	inst.components.combat.damagemultiplier = 0.7
	inst.components.health.absorb = 0.3
	inst.level = 0
	inst.sora_exp = 0
	inst.sora_maxexp = 50
	
	--レベル
	local function Sora_Level(inst)
		inst.sora_maxexp = math.ceil( inst.sora_maxexp * 1.06 )
		local reberu = math.min(inst.level, 70)
		
		local hunger_percent = inst.components.hunger:GetPercent()
		local health_percent = inst.components.health:GetPercent()
		local sanity_percent = inst.components.sanity:GetPercent()

		inst.components.health.maxhealth = math.ceil (100 + reberu * 0.8)
		inst.components.hunger.max = math.ceil (80 + reberu * 0.5)
		inst.components.sanity.max = math.ceil (80 + reberu * 0.8)
		
		inst.components.hunger:SetPercent(hunger_percent)
		inst.components.health:SetPercent(health_percent)
		inst.components.sanity:SetPercent(sanity_percent)
	end

	--精神回復
	inst:DoPeriodicTask(0, function()
		local temp = 0
		local x, y, z = inst.Transform:GetWorldPosition()
		local ents = TheSim:FindEntities(x, y, z, 10)
		for k,v in pairs(ents) do
			if v.prefab ~= "sora" and v:HasTag("player") then
				temp = temp + 1
			end
		end
		if temp > 0 then
			inst.components.sanity.dapperness = TUNING.DAPPERNESS_LARGE
		else
			inst.components.sanity.dapperness = 0
		end
	end)
	--眠る
	inst.seisin = true
	inst:DoPeriodicTask(1, function()
		if inst:HasTag("sleeping") then
		inst.seisin = true
			if inst.sora_exp <= inst.sora_maxexp and inst.level <=70 then
				inst.sora_exp =  math.ceil( inst.sora_exp + (( 100 + math.random() * inst.sora_maxexp * (math.random()*0.06)) * math.random()) )
				else
				inst.sora_exp = 0
				if inst.level <= 70 then
					inst.level = inst.level + 1
					Sora_Level(inst)
				end
			end 
		end
	end)
	inst:DoPeriodicTask(200 + math.random() * 100, function()
		inst:PushEvent("yawn")
		inst.seisin = false
	end)
	inst:DoPeriodicTask(1200 + math.random() * 240, function()
		if inst.seisin == false then
		inst:PushEvent("yawn", { grogginess = math.random() * 30 })
		end
	end)
	--奨励
	inst:ListenForEvent("killed", function(inst, data)
		if data.victim:HasTag("monster") and data.victim.prefab ~= "spider" then
			if math.random() < .4 then
				if data.victim.components.lootdropper then
					data.victim.components.lootdropper:SpawnLootPrefab("dekiru")
				end
			end 
		end 
	end)
	
inst.OnPreLoad = function(inst, data)
	if data then
		if data.level then
			inst.level = data.level
			Sora_Level(inst)
			if data.health and data.health.health then inst.components.health.currenthealth = data.health.health end
			if data.hunger and data.hunger.hunger then inst.components.hunger.current = data.hunger.hunger end
			if data.sanity and data.sanity.current then inst.components.sanity.current = data.sanity.current end
			inst.components.health:DoDelta(0)
			inst.components.hunger:DoDelta(0)
			inst.components.sanity:DoDelta(0)
		end
		inst.sora_maxexp = data.sora_maxexp
		Sora_Level(inst)
	end
end

inst.OnSave = function(inst, data) data.level = inst.level data.sora_maxexp = inst.sora_maxexp end
	
end, 
{
})