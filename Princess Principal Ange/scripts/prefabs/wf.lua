local assets =
{
	Asset("ANIM", "anim/wf.zip"),
    Asset("ANIM", "anim/swap_wf.zip"),
	Asset("SOUNDPACKAGE", "sound/wf.fev"),	
	Asset("SOUND", "sound/wf.fsb"),  
}

local prefabs =
{
	"impact",
}



local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "swap_wf", "wf")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal") 
    local ammo_loaded = inst.components.finiteuses:GetUses()
    if ammo_loaded > 10 then
        inst.components.weapon:SetDamage(TUNING.WF_DAMAGE)
        inst.components.weapon:SetRange(12)
        inst.components.weapon:SetProjectile("bullet")
		inst:RemoveTag("spear")
		inst:AddTag("blowdart")
		owner.components.combat.min_attack_period = 0.8
    else
        inst.components.weapon:SetProjectile(nil)
        inst.components.weapon:SetRange(0,0)
        inst.components.weapon:SetDamage(20)
		inst:RemoveTag("blowdart")
		inst:AddTag("spear")
		owner.components.combat.min_attack_period = 0.1
    end
end

local function onunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
	owner.components.combat.min_attack_period = 0.1
	local ammo = owner.components.inventory:FindItem(function(item) return item.prefab=="ammo" end)
	local ammo_loaded = inst.components.finiteuses:GetUses()
	if ammo_loaded <100 and ammo ~= nil then
		ammo.components.stackable:Get(1):Remove()
		inst.components.finiteuses:SetUses(100)
		ammo = owner.components.inventory:FindItem(function(item) return item.prefab=="ammo" end)
	end
	if ammo_loaded <200 and ammo ~= nil then	
		ammo.components.stackable:Get(1):Remove()
		inst.components.finiteuses:SetUses(200)
		ammo = owner.components.inventory:FindItem(function(item) return item.prefab=="ammo" end)
	end
	if ammo_loaded <300 and ammo ~= nil then	
		ammo.components.stackable:Get(1):Remove()
		inst.components.finiteuses:SetUses(300)
		ammo = owner.components.inventory:FindItem(function(item) return item.prefab=="ammo" end)
	end
	if ammo_loaded <400 and ammo ~= nil then	
		ammo.components.stackable:Get(1):Remove()
		inst.components.finiteuses:SetUses(400)
		ammo = owner.components.inventory:FindItem(function(item) return item.prefab=="ammo" end)
	end
	if ammo_loaded <500 and ammo ~= nil then	
		ammo.components.stackable:Get(1):Remove()
		inst.components.finiteuses:SetUses(500)
	end
	if ammo_loaded <600 and ammo ~= nil then	
		ammo.components.stackable:Get(1):Remove()
		inst.components.finiteuses:SetUses(600)
	end
end

local function onattack(inst, attacker, target)
	local ammo = attacker.components.inventory:FindItem(function(item) return item.prefab=="ammo" end)
    local ammo_loaded = inst.components.finiteuses:GetUses()
	if ammo_loaded > 10 then
		attacker.components.combat.min_attack_period = 0.9
		inst.components.finiteuses:SetUses(ammo_loaded - 99)
	end
	if ammo_loaded > 100 then
		--attacker.SoundEmitter:KillSound("blowdart")
		attacker.SoundEmitter:PlaySound("wf/wfsound/wf")
		else
		if ammo_loaded > 10 and ammo == nil then
			attacker.SoundEmitter:PlaySound("wf/wfsound/wf")
		end
	end
	ammo_loaded = inst.components.finiteuses:GetUses()
	if ammo_loaded < 10 then
		
		ammo_loaded = inst.components.finiteuses:GetUses()
		if ammo == nil then
			inst.components.weapon:SetProjectile(nil)
			inst.components.weapon:SetRange(0)
			inst.components.weapon:SetDamage(20)
			inst:RemoveTag("blowdart")
			inst:AddTag("spear")
			inst.components.finiteuses:SetUses(0)
			attacker.components.combat.min_attack_period = 0.1	
		end
		if attacker.components.combat.min_attack_period ~= 0.1 then
			if ammo_loaded <100 and ammo ~= nil then
				attacker.components.combat.min_attack_period = 0.8
				attacker.SoundEmitter:PlaySound("wf/wfsound/wf")

				ammo.components.stackable:Get(1):Remove()
				inst.components.finiteuses:SetUses(100)
				ammo = attacker.components.inventory:FindItem(function(item) return item.prefab=="ammo" end)
			end
			if ammo_loaded <200 and ammo ~= nil then	
				ammo.components.stackable:Get(1):Remove()
				inst.components.finiteuses:SetUses(200)
				ammo = attacker.components.inventory:FindItem(function(item) return item.prefab=="ammo" end)
			end
			if ammo_loaded <300 and ammo ~= nil then	
				ammo.components.stackable:Get(1):Remove()
				inst.components.finiteuses:SetUses(300)
				ammo = attacker.components.inventory:FindItem(function(item) return item.prefab=="ammo" end)
			end
			if ammo_loaded <400 and ammo ~= nil then	
				ammo.components.stackable:Get(1):Remove()
				inst.components.finiteuses:SetUses(400)
				ammo = attacker.components.inventory:FindItem(function(item) return item.prefab=="ammo" end)
			end
			if ammo_loaded <500 and ammo ~= nil then	
				ammo.components.stackable:Get(1):Remove()
				inst.components.finiteuses:SetUses(500)
			end
			if ammo_loaded <600 and ammo ~= nil then	
				ammo.components.stackable:Get(1):Remove()
				inst.components.finiteuses:SetUses(600)
			end
		end
    end
end


	

local function fn()
	local inst = CreateEntity()
	
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("wf")
    inst.AnimState:SetBuild("wf")
    inst.AnimState:PlayAnimation("idle")
    --inst:AddTag("needssewing")
	inst:AddTag("sharp")
	
    if not TheWorld.ismastersim then
        return inst
    end
    inst.entity:SetPristine()
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/wf.xml"
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(600)  --  [note]:MaxLoadedAmmo == MaxUses / 100
    inst.components.finiteuses:SetUses(0)
	
	--inst.components.finiteuses:SetOnFinished(inst.Remove)

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(20)
    inst.components.weapon:SetRange(0)
    inst.components.weapon:SetProjectile(nil)
    inst.components.weapon:SetOnAttack(onattack)

    MakeHauntableLaunch(inst)
    return inst
end

return Prefab( "common/inventory/wf", fn, assets,prefabs) 