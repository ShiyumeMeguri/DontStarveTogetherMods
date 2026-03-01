local function saniup(inst)
	if inst.isWeared and not inst.isDropped then
		inst.components.equippable.dapperness = 0.05
	end
end

local function onEquip(inst, owner) 
	owner.AnimState:OverrideSymbol("swap_hat", "live_headwear", "swap_hat")
	owner.AnimState:Show("HAT")
	owner.AnimState:Show("HAT_HAIR")
	
	inst.isWeared = true
	inst.isDropped = false
	saniup(inst)
end

local function onUnEquip(inst, owner) 
	owner.AnimState:Hide("HAT")
	owner.AnimState:Hide("HAT_HAIR")
	owner.AnimState:Show("HAIR_NOHAT")
	owner.AnimState:Show("HAIR")
	
	inst.isWeared = false
	inst.isDropped = false
	saniup(inst)
end

local function ondrop(inst)
	inst.isDropped = true
	inst.isWeared = false
	saniup(inst)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	
    MakeInventoryPhysics(inst)
	    
	inst.isWeared = false
	inst.isDropped = false
		
	if not TheWorld.ismastersim then
        return inst
    end
	
	inst.AnimState:SetBank("live_headwear")
	inst.AnimState:SetBuild("live_headwear")
	inst.AnimState:PlayAnimation("anim")
	
	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/live_headwear.xml"
	
	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
	inst.components.equippable:SetOnEquip(onEquip)
	inst.components.equippable:SetOnUnequip(onUnEquip)
	inst.components.inventoryitem:SetOnDroppedFn(ondrop)
	
	inst:ListenForEvent("phasechanged", function() saniup(inst) end, TheWorld)
	
    return inst
end

return Prefab("common/inventory/live_headwear", fn)