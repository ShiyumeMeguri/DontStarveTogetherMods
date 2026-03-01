AddGamePostInit(function()
	AAB_ReplaceCharacterLines("willow")
end)

--AAB_ActivateSkills("willow")
-- AAB_ActivateSkills --这个函数是开启某个角色后会载入对应角色名称的技能树 -- 目前已经被我限制成为只能某个指定人物名称 kana 才能开启
AAB_ActivateSkills("willow") -- 这开启好像不影响 其他大型mod  因为我限制只能kana使用 
-- AAB_ActivateSkills --这个函数是开启某个角色后会载入对应角色名称的技能树 -- 目前已经被我限制成为只能某个指定人物名称 kana 才能开启

local willow_ember_common

local function OnBecameGhost(inst)
    if inst._aab_willow_onentitydroplootfn ~= nil then
        inst:RemoveEventCallback("entity_droploot", inst._aab_willow_onentitydroplootfn, TheWorld)
        inst._aab_willow_onentitydroplootfn = nil
    end
    if inst._aab_willow_onentitydeathfn ~= nil then
        inst:RemoveEventCallback("entity_death", inst._aab_willow_onentitydeathfn, TheWorld)
        inst._aab_willow_onentitydeathfn = nil
    end
end

local function IsValidVictim(victim, explosive)
    return willow_ember_common.HasEmbers(victim) and (victim.components.health:IsDead() or explosive)
end

local function OnRestorEmber(victim)
    victim.noembertask = nil
end

local function OnEntityDropLoot(inst, data)
    local victim = data.inst
    if victim ~= nil and
        victim.noembertask == nil and
        victim:IsValid() and
        (victim == inst or
            (not inst.components.health:IsDead() and
                IsValidVictim(victim) and
                inst:IsNear(victim, TUNING.WILLOW_EMBERDROP_RANGE)
            )
        ) then
        --V2C: prevents multiple Willows in range from spawning multiple embers per corpse
        victim.noembertask = victim:DoTaskInTime(5, OnRestorEmber)
        willow_ember_common.SpawnEmbersAt(victim, willow_ember_common.GetNumEmbers(victim))
    end
end

local function OnEntityDeath(inst, data)
    if data.inst ~= nil then
        data.inst._embersource = data.afflicter                             -- Mark the victim.
        if (data.inst.components.lootdropper == nil or data.explosive) then -- NOTES(JBK): Explosive entities do not drop loot.
            OnEntityDropLoot(inst, data)
        end
    end
end

local function OnRespawnedFromGhost(inst)
    inst.components.freezable:SetResistance(3)

    if inst._aab_willow_onentitydroplootfn == nil then
        inst._aab_willow_onentitydroplootfn = function(src, data) OnEntityDropLoot(inst, data) end
        inst:ListenForEvent("entity_droploot", inst._aab_willow_onentitydroplootfn, TheWorld)
    end
    if inst._aab_willow_onentitydeathfn == nil then
        inst._aab_willow_onentitydeathfn = function(src, data) OnEntityDeath(inst, data) end
        inst:ListenForEvent("entity_death", inst._aab_willow_onentitydeathfn, TheWorld)
    end
end

local function TryToOnRespawnedFromGhost(inst)
    if not inst.components.health:IsDead() and not inst:HasTag("playerghost") then
        OnRespawnedFromGhost(inst)
    end
end



AddPlayerPostInit(function(inst)

	
    if inst.prefab == "willow" then return end---如果当前人物是沃拓克斯 恶魔人 那么下面的代码无效  
	
		
	
	 -----私有化代码 如下两个代码就可以让其他人无法用这个技能 
	
	 --[[]]
	 if inst.prefab == "kana" then  -----私有化代码 如下两个代码就可以让其他人无法用这个技能 
		
	    inst:AddTag("pyromaniac")
	    if not TheWorld.ismastersim then return end
	    willow_ember_common = require("prefabs/willow_ember_common")
	 --这三个代码会导致飞kana和火女的人物在燃烧生物的时候不出现 余烬  d但是依然有类似火女的 闷烧 和打火机的能力
	 
	 --分别是 可以用打火机  有闷烧  可以使用余烬 和吸收余烬 但是无法制造余烬 
		inst:ListenForEvent("ms_becameghost", OnBecameGhost)   
		inst:ListenForEvent("ms_respawnedfromghost", OnRespawnedFromGhost)
		inst:DoTaskInTime(0, TryToOnRespawnedFromGhost) -- NOTES(JBK): Player loading in with zero health will still be alive here delay a frame to get loaded values.
    --    OnRespawnedFromGhost(inst)
		  
	 end 
	 -----私有化代码 如下两个代码就可以让其他人无法用这个技能 
	
   

    

   

   
    
end)
