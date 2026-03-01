local function onEquip(inst, owner) 
	owner.AnimState:OverrideSymbol("swap_hat", "neko_hat", "swap_hat")
	owner.AnimState:Show("HAT")
	owner.AnimState:Show("HEAD_HAT")
	owner.AnimState:Hide("HEAD")
end

local function onUnEquip(inst, owner) 
	owner.AnimState:Hide("HAT")
	owner.AnimState:Hide("HEAD_HAT")
	owner.AnimState:Show("HEAD")
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	
    MakeInventoryPhysics(inst)
	    
	if not TheWorld.ismastersim then
        return inst
    end
	
	inst.AnimState:SetBank("neko_hat")
	inst.AnimState:SetBuild("neko_hat")
	inst.AnimState:PlayAnimation("anim")
	
	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/neko_hat.xml"
	
	inst:AddComponent("armor")
	inst.components.armor:InitCondition(1378, 0.5)
	
	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
	inst.components.equippable:SetOnEquip(onEquip)
	inst.components.equippable:SetOnUnequip(onUnEquip)
	inst.components.equippable.walkspeedmult = 1.3
	
    inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_LARGE)
	
	
    return inst
end

return Prefab("common/inventory/neko_hat", fn)