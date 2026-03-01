
local function fn()

    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("croquette")
    inst.AnimState:SetBuild("croquette")
    inst.AnimState:PlayAnimation("idle")
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
	inst:AddComponent("inventoryitem") 
	inst.components.inventoryitem.atlasname = "images/inventoryimages/croquette.xml"
	inst.components.inventoryitem:ChangeImageName("croquette")

    inst:AddComponent("edible")
    inst.components.edible.healthvalue = 5
    inst.components.edible.hungervalue = 20
    inst.components.edible.sanityvalue = 10
    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("common/inventory/croquette", fn)