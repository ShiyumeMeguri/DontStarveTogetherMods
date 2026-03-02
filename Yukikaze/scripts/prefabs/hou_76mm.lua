local function OnThrown(inst, data)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
end

local function OnEquip(inst, owner)
	owner:AddTag("76mm")
end 

local function OnUnequip(inst, owner)
	owner:RemoveTag("76mm")
end

local function fn() 
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState() 
	
	inst.entity:AddNetwork()
	
	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("hou_76mm")
	inst.AnimState:SetBuild("hou_76mm")
	inst.AnimState:PlayAnimation("idle")
	inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then 
	return inst  
	end
    inst:AddComponent("inspectable")
	
	inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(10)
	
	inst:AddComponent("inventoryitem") 
	inst.components.inventoryitem.imagename = "hou_76mm"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hou_76mm.xml"
	inst.components.inventoryitem.keepondeath = true

	inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
	inst.components.equippable:SetOnEquip(OnEquip)
	inst.components.equippable:SetOnUnequip(OnUnequip)
	MakeHauntableLaunch(inst)
	
	if not inst.components.characterspecific then
    	inst:AddComponent("characterspecific")
	end
	
	inst.components.characterspecific:SetOwner("yukikaze")
    inst.components.characterspecific:SetStorable(true)
    inst.components.characterspecific:SetComment("これは艦娘用です.")
	
	return inst
end

return Prefab("common/inventory/hou_76mm", fn)