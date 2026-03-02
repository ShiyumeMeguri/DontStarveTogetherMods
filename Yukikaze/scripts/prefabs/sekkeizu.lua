
local function fn()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("sekkeizu")
	inst.AnimState:SetBuild("sekkeizu")
	inst.AnimState:PlayAnimation("idle")
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("bait")

	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	
	inst:AddComponent("inventoryitem") 
	inst.components.inventoryitem.imagename = "sekkeizu"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/sekkeizu.xml"
	
	inst:AddComponent("fuel")
	inst.components.fuel.fuelvalue = TUNING.MED_FUEL

	inst:AddComponent("inspectable")

	inst:AddComponent("tradable")
	inst.components.tradable.goldvalue = TUNING.GOLD_VALUES.MEAT

	MakeHauntableLaunch(inst)
	return inst
end

return Prefab("common/inventory/sekkeizu", fn)