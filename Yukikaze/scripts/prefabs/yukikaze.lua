yukikaze_hanasu0 = 0
yukikaze_hanasu1 = 0
yukikaze_hanasu2 = 0

local MakePlayerCharacter = require "prefabs/player_common"
--レベル
local function applyupgrades(inst)
	local max_upgrades = 100
	local upgrades = math.min(inst.level, max_upgrades)
	
	local hunger_percent = inst.components.hunger:GetPercent()
	local health_percent = inst.components.health:GetPercent()
	local sanity_percent = inst.components.sanity:GetPercent()

	if TUNING.ONKEKON==1 then
	inst.components.hunger.max = 100 + upgrades * 0.94 * 1.1
	inst.components.health.maxhealth = 35.9 + upgrades * 1.61 * 1.1
	inst.components.sanity.max = 100 + upgrades * 0.5 * 1.1
	
	inst.components.locomotor.walkspeed = math.ceil(6 + upgrades/24) * 1.1
	inst.components.locomotor.runspeed = math.ceil(8 + upgrades/24) * 1.1
	else
	inst.components.hunger.max = 100 + upgrades * 0.94
	inst.components.health.maxhealth = 35.9 + upgrades * 1.61
	inst.components.sanity.max = 100 + upgrades * 0.5
	
	inst.components.locomotor.walkspeed = math.ceil(6 + upgrades/24)
	inst.components.locomotor.runspeed = math.ceil(8 + upgrades/24)
	end
	
	inst:DoTaskInTime(1.5, function()
	inst.components.talker:Say(TUNING.YUKIKAZEIU1.. (inst.level))
	end)
	
	if inst.level >69 then
		inst:AddTag("level2")
	end

	inst.components.hunger:SetPercent(hunger_percent)
	inst.components.health:SetPercent(health_percent)
	inst.components.sanity:SetPercent(sanity_percent)
end

--殺す
local function onkilledother(inst, data)
	local victim = data.victim
	if victim:HasTag("monster") and victim:HasTag("hostile") then
		if inst.components.yukikaze_exp.current <100000 then
			inst.components.yukikaze_exp:DoDelta(math.random(500))
			inst:DoTaskInTime(3, function()
			inst.components.talker:Say(TUNING.YUKIKAZEIU.. (inst.components.yukikaze_exp.current))
			end)
			inst.level = math.floor(inst.components.yukikaze_exp.current/1000)
			applyupgrades(inst)
		end	
	end
	
	if victim:HasTag("moose") or victim:HasTag("dragonfly") or victim:HasTag("bearger") or victim:HasTag("bearger") or victim:HasTag("toadstool") then
		if inst.components.yukikaze_exp.current <100000 then
			inst.components.yukikaze_exp:DoDelta(math.random(10000))
			inst.SoundEmitter:PlaySound("yukikaze/yukikazesound/syori")
			inst:DoTaskInTime(3, function()
				inst.components.talker:Say(TUNING.YUKIKAZEIU.. (inst.components.yukikaze_exp.current))
			end)
		end
	end
	if victim:HasTag("Warg") or victim:HasTag("spiderqueen") or victim:HasTag("leif") or victim:HasTag("minotaur") then
			if inst.components.yukikaze_exp.current <100000 then
			inst.components.yukikaze_exp:DoDelta(math.random(3000))
			inst.SoundEmitter:PlaySound("yukikaze/yukikazesound/syori")
			inst:DoTaskInTime(3, function()
				inst.components.talker:Say(TUNING.YUKIKAZEIU.. (inst.components.yukikaze_exp.current))
			end)
		end
	end
end

--いただく
local function oneat(inst, food)
	if food and food.components.edible and food.prefab == "petals" then
		if math.random()>0.5 then
			inst.components.koukan:DoDelta(1)
			inst:DoTaskInTime(0.01, function()
				inst.components.talker:Say(TUNING.YUKIKAZEIU2)
			end)
		end
	end
	
	if food and food.components.edible and food.prefab == "watermelon" or food.prefab == "fish" or food.prefab == "fish_cooked" and food.prefab == "eel" or food.prefab == "eel_cooked" or food.prefab == "fishtacos" or food.prefab == "fishsticks" or food.prefab == "unagi" then
			inst.components.koukan:DoDelta(2)
		if inst.components.yukikaze_exp.current <100000 then
			inst.components.yukikaze_exp:DoDelta(1000)
			inst:DoTaskInTime(3, function()
			inst.components.talker:Say(TUNING.YUKIKAZEIU.. (inst.components.yukikaze_exp.current))
			end)
			inst.level = math.floor(inst.components.yukikaze_exp.current/1000)
			applyupgrades(inst)
		end	
		
		if (inst.components.koukan.currenttimepiont)>=28 and (inst.components.koukan.currenttimepiont)<63 and yukikaze_hanasu0~=1 then
				inst.SoundEmitter:PlaySound("yukikaze/yukikazesound/shiriai")
				yukikaze_hanasu0=1
			elseif (inst.components.koukan.currenttimepiont)>=63 and (inst.components.koukan.currenttimepiont)<91 and yukikaze_hanasu1~=1 then
				inst.SoundEmitter:PlaySound("yukikaze/yukikazesound/suki")
				yukikaze_hanasu1=1
			elseif (inst.components.koukan.currenttimepiont)>=91 and (inst.components.koukan.currenttimepiont)<=100 and yukikaze_hanasu2~=1 then
				inst.SoundEmitter:PlaySound("yukikaze/yukikazesound/rabu")
				yukikaze_hanasu2=1
			end


			inst:DoTaskInTime(0.01, function()
		inst.components.talker:Say(TUNING.YUKIKAZEIU3)
		end)
	end
	
	if food and food.components.edible and food.prefab == "spoiled_food" or food.prefab == "plantmeat" or food.prefab == "plantmeat_cooked" or food.prefab == "batwing" or food.prefab == "batwing_cooked" then
		inst.components.koukan:DoDelta(-30)
		inst:DoTaskInTime(0.01, function()
		inst.components.talker:Say(TUNING.YUKIKAZEIU4)
		end)
	end
	
	if food and food.components.edible and food.prefab == "monsterlasagna" then
		inst.components.koukan:DoDelta(-15)
		inst:DoTaskInTime(0.01, function()
		inst.components.talker:Say(TUNING.YUKIKAZEIU5)
		end)
	end

	if food and food.components.edible and food.prefab == "monstermeat" then
		inst.components.koukan:DoDelta(-10)
		inst:DoTaskInTime(0.01, function()
		inst.components.talker:Say(TUNING.YUKIKAZEIU6)
		end)
	end
	if TUNING.ONKEKON == 0 then
			if (inst.components.koukan.currenttimepiont)>=100 then
				inst:AddTag("kekonsuru")
			else
				inst:RemoveTag("kekonsuru")
			end
		end
end

--蘇生
local function onbecamehuman(inst)
	applyupgrades(inst)
end

--ロード
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
	
    if not inst:HasTag("playerghost") then
        onbecamehuman(inst)
    end
end

--プリロード
local function onpreload(inst, data)
		TUNING.MOVEIMAGE1 = data.moveimage1
		if TUNING.MOVEIMAGE1 == 0 then
			inst:AddTag("kekonsuru")
		end
		TUNING.ONKEKON = data.onkekon
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
		applyupgrades(inst)
	if data.absorb then
		inst.components.health.absorb = data.absorb
	end
	if data.hungerrate then
		inst.components.hunger.hungerrate = data.hungerrate
	end
	if data.damagemultiplier then
		inst.components.combat.damagemultiplier = data.damagemultiplier
	end
	if data.inherentinsulation then
		inst.components.temperature.inherentinsulation = data.inherentinsulation
	end
end

--セーブ
local function onsave(inst, data)
	data.level = inst.level
	data.moveimage1 = TUNING.MOVEIMAGE1
	data.onkekon = TUNING.ONKEKON
	data.hungerrate = inst.components.hunger.hungerrate or nil
	data.absorb = inst.components.health.absorb or nil
	data.damagemultiplier = inst.components.combat.damagemultiplier or nil
	data.inherentinsulation = inst.components.temperature.inherentinsulation or nil
end

return MakePlayerCharacter("yukikaze", {}, {}, 
function(inst) 
	inst.currentyukikaze = net_shortint(inst.GUID,"currentyukikaze")
	inst.MiniMapEntity:SetIcon( "yukikaze.tex" )
	inst:AddTag("yukikaze_skiller")
end, 
function(inst)
	inst.level = 0
	applyupgrades(inst)
	inst.components.eater:SetOnEatFn(oneat)
	inst:AddComponent("yukikaze_exp")
	inst:AddComponent("reader")	
    inst:AddComponent("leader")
    inst:AddComponent("knownlocations")
	inst.soundsname = "willow"
	inst:AddTag("yukikaze")
	
	if TUNING.ONKEKON==1 then
	inst.components.health:SetMaxHealth(35.9*1.1)
	inst.components.hunger:SetMax(100*1.1)
	inst.components.sanity:SetMax(100*1.1)
	inst.components.combat.damagemultiplier = 1.2
	inst.components.combat.min_attack_period = 0.4
	inst.components.health:StartRegen(1, 60)
	else
	inst.components.health:SetMaxHealth(35.9)
	inst.components.hunger:SetMax(100)
	inst.components.sanity:SetMax(100)
	end
	
	inst:ListenForEvent("killed", onkilledother)
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
	inst.components.locomotor.walkspeed = 6
	inst.components.locomotor.runspeed = 8
end, 
{
"petals",
})
