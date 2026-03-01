
local function fn()

    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("dekiru")
    inst.AnimState:SetBuild("dekiru")
    inst.AnimState:PlayAnimation("idle")
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
	
    inst:AddComponent("inspectable")
	inst:AddComponent("inventoryitem") 
	inst.components.inventoryitem.atlasname = "images/inventoryimages/dekiru.xml"
	inst.components.inventoryitem:ChangeImageName("dekiru")

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("common/inventory/dekiru", fn)