local function saniup(inst)
	if inst.isWeared and not inst.isDropped then
		inst.components.equippable.dapperness = 10---回复精神值
		inst:AddComponent("armor")---加入护甲能力
		inst:AddTag("hide_percentage")--隐藏耐久
		inst.components.armor:InitIndestructible(0.5)---只有防御没有耐久防御50%
	end
end

local function onEquip(inst, owner) 
	owner.AnimState:OverrideSymbol("swap_hat", "headwear", "swap_hat")
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
	
	inst.AnimState:SetBank("headwear")
	inst.AnimState:SetBuild("headwear")
	inst.AnimState:PlayAnimation("anim")
	
	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/headwear.xml"
	
	inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
	inst.components.equippable:SetOnEquip(onEquip)
	inst.components.equippable:SetOnUnequip(onUnEquip)
	inst.components.inventoryitem:SetOnDroppedFn(ondrop)
	
	inst:ListenForEvent("phasechanged", function() saniup(inst) end, TheWorld)
	
    return inst
end

return Prefab("common/inventory/headwear", fn)