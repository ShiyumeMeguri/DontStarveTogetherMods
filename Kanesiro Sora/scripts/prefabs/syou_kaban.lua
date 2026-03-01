local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("syou_kaban", "swap_syoukaban", "syou_kaban")
    owner.AnimState:OverrideSymbol("swap_body", "swap_syoukaban", "swap_body")
    owner:AddTag("syou_kaban")
    inst.components.container:Open(owner)
end

local function onunequip(inst, owner)
    owner.AnimState:ClearOverrideSymbol("swap_body")
    owner.AnimState:ClearOverrideSymbol("syou_kaban")
    owner:RemoveTag("syou_kaban")
    if inst.components.container ~= nil then
		inst.components.container:Close(owner)
	end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.MiniMapEntity:SetIcon("backpack.png")

    inst.AnimState:SetBank("sora_syoukaban")
    inst.AnimState:SetBuild("swap_syoukaban")
    inst.AnimState:PlayAnimation("anim")

    inst:AddTag("backpack")
	
	inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("inspectable")

	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.cangoincontainer = false
	inst.components.inventoryitem.foleysound = "dontstarve/movement/foley/marblearmour"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/syou_kaban.xml"
	
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
	
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("backpack")

    MakeHauntableLaunchAndDropFirstItem(inst)

    return inst
end

return Prefab("common/inventory/syou_kaban", fn)