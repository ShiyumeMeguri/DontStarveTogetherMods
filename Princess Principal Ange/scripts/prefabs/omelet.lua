local Assets =
{
	Asset("ANIM", "anim/omelet.zip"),
    Asset("ATLAS", "images/inventoryimages/omelet.xml"),
}

local prefabs = 
{
	"spoiled_food",
}

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeSmallBurnable(inst)
	MakeSmallPropagator(inst)
	
	inst.AnimState:SetBank("omelet")
	inst.AnimState:SetBuild("omelet")
	inst.AnimState:PlayAnimation("idle")
	
	inst:AddTag("preparedfood")
	inst:AddTag("honeyed")

	inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
	
	
	inst:AddComponent("edible")
	inst.components.edible.foodtype = "MEAT"
	inst.components.edible.healthvalue = 30
	inst.components.edible.hungervalue = 50
	inst.components.edible.sanityvalue = 25

	inst:AddComponent("inspectable")
	
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/omelet.xml"
	
	inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_PRESERVED*10)
	inst.components.perishable:StartPerishing()
	inst.components.perishable.onperishreplacement = "spoiled_food"

	inst:AddComponent("bait")
	
	inst:AddComponent("tradable")
	
	return inst
end


return Prefab( "common/inventory/omelet", fn, Assets )