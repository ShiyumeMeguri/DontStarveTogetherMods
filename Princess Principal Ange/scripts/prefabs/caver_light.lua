local assets=
{   
	Asset("ANIM", "anim/caver_light.zip"),
	Asset("ATLAS", "images/inventoryimages/caver_light.xml"),
}

local function saniup(inst)
		inst.components.equippable.dapperness = 0.1
end

local function onblink(staff, pos, caster)
    local caster = staff.components.inventoryitem.owner
    caster.components.sanity:DoDelta(-10)
	local x, y, z = caster.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, 5)
end

local function fn(Sim)  

	local inst = CreateEntity()    
	local trans = inst.entity:AddTransform()    
	local anim = inst.entity:AddAnimState()  	
	inst.entity:AddNetwork()
	
	MakeInventoryPhysics(inst)     	
	inst.AnimState:SetBank("caver_light")    
	inst.AnimState:SetBuild("caver_light")    
	inst.AnimState:PlayAnimation("idle")
	
	inst:AddComponent("armor")
	
    inst.components.armor:InitCondition(999999,  .5) 
    	if not TheWorld.ismastersim then
        	return inst
    	end
	
    inst:AddComponent("blinkstaff")
    inst.components.blinkstaff.onblinkfn = onblink
	
	inst.entity:SetPristine()
	inst:AddComponent("inspectable")       
	
	inst:AddComponent("inventoryitem") 
	inst.components.inventoryitem.atlasname = "images/inventoryimages/caver_light.xml"
	
	inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
	inst.components.equippable.walkspeedmult = 1.2
	
	inst:ListenForEvent("phasechanged", function() saniup(inst) end, TheWorld)
	return inst
end

return Prefab("common/inventory/caver_light", fn, assets, prefabs)