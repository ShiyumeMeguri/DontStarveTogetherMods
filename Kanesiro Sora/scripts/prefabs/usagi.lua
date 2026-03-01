
local function fn()

    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("usagi")
    inst.AnimState:SetBuild("usagi")
    inst.AnimState:PlayAnimation("idle")
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("dakimakura")
	
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(12)
    inst.components.finiteuses:SetUses(12)
    inst.components.finiteuses:SetOnFinished(inst.Remove)
	
    inst:AddComponent("inspectable")
	inst:AddComponent("inventoryitem") 
	inst.components.inventoryitem.atlasname = "images/inventoryimages/usagi.xml"
	inst.components.inventoryitem:ChangeImageName("usagi")

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("common/inventory/usagi", fn)