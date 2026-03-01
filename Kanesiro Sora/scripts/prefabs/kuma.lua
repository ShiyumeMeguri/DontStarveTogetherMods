
local function fn()

    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("kuma")
    inst.AnimState:SetBuild("kuma")
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
	inst.components.inventoryitem.atlasname = "images/inventoryimages/kuma.xml"
	inst.components.inventoryitem:ChangeImageName("kuma")

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("common/inventory/kuma", fn)