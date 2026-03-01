local assets =
{
	 Asset("ANIM", "anim/bullet.zip"),
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

    inst.AnimState:SetBank("bullet")
    inst.AnimState:SetBuild("bullet")
    inst.AnimState:PlayAnimation("idle")

   


    if not TheWorld.ismastersim then
        return inst
    end
    inst.entity:SetPristine()
	--
    --inst:AddComponent("finiteuses")
	--inst.components.finiteuses:SetMaxUses(TUNING.SEWINGKIT_USES)
   -- inst.components.finiteuses:SetUses(TUNING.SEWINGKIT_USES)
	--inst.components.finiteuses:SetOnFinished(inst.Remove)
	
	--inst:AddComponent("sewing")
	--inst.components.sewing.repair_value = TUNING.SEWINGKIT_REPAIR_VALUE
    --inst.components.sewing.onsewn = onsewn
	--inst:AddComponent("inspectable")
	--
    --inst:AddComponent("inventoryitem")
    --inst.components.inventoryitem.atlasname = "images/inventoryimages/ammo.xml"
    --inst:AddComponent("stackable")
    inst:AddComponent("projectile")
    inst.components.projectile:SetSpeed(100)
    inst.components.projectile:SetOnHitFn(inst.Remove)
    inst.components.projectile:SetOnMissFn(inst.Remove)
    inst.components.projectile:SetOnThrownFn(onthrown)

    return inst
end

--STRINGS.NAMES.AMMO                               = "ammo"
--STRINGS.RECIPE_DESC.AMMO                       = "..."

return Prefab( "common/inventory/bullet", fn, assets) 