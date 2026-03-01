
local function fn()

    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("hitsuji")
    inst.AnimState:SetBuild("hitsuji")
    inst.AnimState:PlayAnimation("idle")
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("dakimakura")
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(14)
    inst.components.finiteuses:SetUses(14)
    inst.components.finiteuses:SetOnFinished(inst.Remove)
	
    inst:AddComponent("inspectable")
	inst:AddComponent("inventoryitem") 
	inst.components.inventoryitem.atlasname = "images/inventoryimages/hitsuji.xml"
	inst.components.inventoryitem:ChangeImageName("hitsuji")

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("common/inventory/hitsuji", fn)