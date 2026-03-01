local assets =
{
	 Asset("ANIM", "anim/ammo.zip"),
}

local function onthrown(inst, data)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
end

local function fn()
	local inst = CreateEntity()

   	inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)

    inst.AnimState:SetBank("ammo")
    inst.AnimState:SetBuild("ammo")
    inst.AnimState:PlayAnimation("idle")

   


    if not TheWorld.ismastersim then
        return inst
    end
    inst.entity:SetPristine()
    inst:AddComponent("inspectable")   
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/ammo.xml"
    inst:AddComponent("stackable")
    MakeHauntableLaunch(inst)
    return inst
end


return Prefab( "common/inventory/ammo", fn, assets) 