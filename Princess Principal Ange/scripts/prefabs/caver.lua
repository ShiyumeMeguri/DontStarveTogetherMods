local assets=
{
    Asset("ANIM", "anim/caver.zip"),
    Asset("ATLAS", "images/inventoryimages/caver.xml"),
}

local function saniup(inst)
		inst.components.equippable.dapperness = 0.05
end


local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
	inst.entity:AddNetwork()
	
	inst:AddTag("sharp")
	inst:AddTag("trader")
	
	anim:SetBank("caver")
    anim:SetBuild("caver")
	anim:PlayAnimation("idle")
	
	inst:AddComponent("inspectable")
	
	inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/caver.xml"
    
	inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
	

	
	inst:ListenForEvent("phasechanged", function() saniup(inst) end, TheWorld)
	return inst
end

return Prefab( "common/inventory/caver", fn, assets)