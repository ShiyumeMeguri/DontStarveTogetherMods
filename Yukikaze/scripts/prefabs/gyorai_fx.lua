local function RemoveSelf(inst)
	local x, y, z = inst.Transform:GetWorldPosition()	
	SpawnPrefab("sparks").Transform:SetPosition(x, y, z)
	inst:Remove()
end

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	inst.AnimState:SetBank("gyorai_fx")
    inst.AnimState:SetBuild("gyorai_fx")
	inst.AnimState:PlayAnimation("spin_loop", true)
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)
	inst:AddTag("NOCLICK")
	inst:AddTag("FX")
	inst:AddTag("gyorai_fx")
    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end
	
	inst.SoundEmitter:PlaySound("dontstarve/wilson/boomerang_throw")
	inst._collide_table = {}
	local radius = 1
	local period = 1/30
	inst:DoPeriodicTask(period, function()
		if inst then
			local x, y, z = inst.Transform:GetWorldPosition()	
			local ents = TheSim:FindEntities(x, y, z, 2)
			for k, v in pairs(ents) do
				if v and v:IsValid() and not v:HasTag("INLIMBO") and v ~= inst.master and 
					not (v.components.follower and v.components.follower.leader == inst.master ) and 
					(TheNet:GetPVPEnabled() or not v:HasTag("player")) and
					not table.contains(inst._collide_table, v.GUID) and 
					not v:HasTag("companion")
				then
					if v.components.health and not v.components.health:IsDead() and v.components.combat then
						SpawnPrefab("sparks").Transform:SetPosition(v:GetPosition():Get())
							inst:DoTaskInTime(0.02, function()
							RemoveSelf(inst)
							end)
						if v.components.combat.Zg_GetAttacked then
							v.components.combat:Zg_GetAttacked(inst.master, 50)
						else
							v.components.combat:GetAttacked(inst.master, 50)
							break
						end
						table.insert(inst._collide_table, v.GUID)
					end
				end
			end
			if inst._targetpos then
				local dist2 = inst._targetpos:Dist( inst:GetPosition() )
				if dist2 <= .5 then
					RemoveSelf(inst)
				end
			end
		end
	end)
	inst:DoTaskInTime(3, function()
		RemoveSelf(inst)
	end)
	inst.RemoveSelf=RemoveSelf
    return inst
end

return Prefab ("gyorai_fx", fn)