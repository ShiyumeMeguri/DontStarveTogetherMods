

local function onEquip(inst, owner) -- If the equipping guy is the player, do some 如果是玩家才启动人如下功能
	owner.AnimState:OverrideSymbol("swap_hat", "headwear2", "swap_hat")
	owner.AnimState:Show("HAT")
	owner.AnimState:Show("HAT_HAIR")
	if owner:HasTag("player") then	
		--制作减半
		inst.isWeared = true
		inst.isDropped = false
		inst.buildmaster = true
		if owner.components.builder ~= nil then
			 owner.components.builder.ingredientmod = .5
		end
		---带上后身体变大
		local nx, ny, nz = owner.Transform:GetScale()
		sizechange(owner, {nx, ny, nz}, nx/8, {nx*1.25, ny*1.25, nz*1.25}, .25, 0.8)
		owner.sg:GoToState("powerup")---变大动画 解决了bug 变小动画不用加 因为加了会下地洞卡服务器 下地洞会触发头盔失效的函数其中owner.sg:GoToState("powerdown")就会导致服务器崩溃
		---这段代码是变大动画 解决bug 
		owner.Transform:SetScale(nx*1.25, ny*1.25, nz*1.25)
		saniup(inst)
	end
end

local function onUnEquip(inst, owner) -- If the equipping guy is the player, do some 如果是玩家才启动人如下功能
		owner.AnimState:Hide("HAT")
		owner.AnimState:Hide("HAT_HAIR")
		owner.AnimState:Show("HAIR_NOHAT")
		owner.AnimState:Show("HAIR")
	if owner:HasTag("player") then
		--制作减半
		inst.isWeared = false
		inst.isDropped = false
		inst.buildmaster = false
		if owner.components.builder ~= nil then
			 owner.components.builder.ingredientmod = 1
		end
		---带上后身体变大
		local nx, ny, nz = owner.Transform:GetScale()
		sizechange(owner, {nx, ny, nz}, -nx/5, {nx*0.8, ny*0.8, nz*0.8}, .25, -0.8)
		--owner.sg:GoToState("powerdown")---变小动画 bug源头
		---这段代码是变大动画 解决bug 
		owner.Transform:SetScale(1, 1,1)	
		saniup(inst)
	end
end

local function ondrop(inst)
	inst.isDropped = true
	inst.isWeared = false
	saniup(inst)
end

---物品损坏和修复
--local mhwgreatswordice_DATA_BROKEN = { bank = "armor_wagpunk_01", anim = "broken" }
--local SWAP_DATA        = { bank = "armor_wagpunk_01", anim = "anim"   }

local function OnBroken(inst)
    if inst.components.equippable ~= nil then
        inst:RemoveComponent("equippable")
        inst.AnimState:PlayAnimation("broken")
		SetIsBroken(inst, true)
        --inst.components.floater:SetSwapData(SWAP_DATA_BROKEN)
        inst:AddTag("broken")
        inst.components.inspectable.nameoverride = "BROKEN_FORGEDITEM"
    end
end
--[[

local function OnRepaired(inst)
    if inst.components.equippable == nil then
        SetupEquippable(inst)
        inst.AnimState:PlayAnimation("anim")
        inst.components.floater:SetSwapData(SWAP_DATA)
        inst:RemoveTag("broken")
        inst.components.inspectable.nameoverride = nil
    end
end
]]--
local function OnRepaired(inst)
	if inst.components.equippable == nil then
		SetupEquippable(inst)
		inst.AnimState:PlayAnimation("idle")
		SetIsBroken(inst, false)
		inst:RemoveTag("broken")
		inst.components.inspectable.nameoverride = nil
	end
end
---物品损坏和修复


--雷哥

local function miner_turnon(inst)
    local owner = inst.components.inventoryitem ~= nil and inst.components.inventoryitem.owner or nil
    if not inst.components.fueled:IsEmpty() then
        if owner ~= nil then
            owner:AddTag("regerbomb")
            onequip(inst, owner)
        end
        local soundemitter = owner ~= nil and owner.SoundEmitter or inst.SoundEmitter
        soundemitter:PlaySound("dontstarve/common/minerhatAddFuel")
    elseif owner ~= nil then
        onequip(inst, owner, "swap_hat_off")
    end
end

local function miner_turnoff(inst)
    local owner = inst.components.inventoryitem ~= nil and inst.components.inventoryitem.owner or nil
    if owner ~= nil and inst.components.equippable ~= nil and inst.components.equippable:IsEquipped() then
        owner:RemoveTag("regerbomb")
        onequip(inst, owner, "swap_hat_off")
    end
end

local function miner_unequip(inst, owner)
    owner:RemoveTag("regerbomb")
    onunequip(inst, owner)
    miner_turnoff(inst)
end

local function miner_perish(inst)
    local equippable = inst.components.equippable
    if equippable ~= nil and equippable:IsEquipped() then
        local owner = inst.components.inventoryitem ~= nil and inst.components.inventoryitem.owner or nil
        if owner ~= nil then
            local data = {
                prefab = inst.prefab,
                equipslot = equippable.equipslot,
            }
            miner_turnoff(inst)
            owner:PushEvent("torchranout", data)
            return
        end
    end
    miner_turnoff(inst)
end

local function miner_takefuel(inst)
    if inst.components.equippable ~= nil and inst.components.equippable:IsEquipped() then
        miner_turnon(inst)
    end
end

local function custom_init(inst)
    inst.entity:AddSoundEmitter()
    inst:AddTag("waterproofer")
end

local function miner_onremove(inst)
    if inst._light ~= nil and inst._light:IsValid() then
        inst._light:Remove()
    end
end

local function item_droppedfn(inst)
    if inst.components.deployable and inst.components.deployable:CanDeploy(inst:GetPosition()) then
        inst.components.deployable:Deploy(inst:GetPosition(), inst)
    end
end

local function storeincontainer(inst, container)
    if container ~= nil and container.components.container ~= nil then
        inst:ListenForEvent("onputininventory", inst._oncontainerownerchanged, container)
        inst:ListenForEvent("ondropped", inst._oncontainerownerchanged, container)
        inst._container = container
    end
end

local function unstore(inst)
    if inst._container ~= nil then
        inst:RemoveEventCallback("onputininventory", inst._oncontainerownerchanged, inst._container)
        inst:RemoveEventCallback("ondropped", inst._oncontainerownerchanged, inst._container)
        inst._container = nil
    end
end

local function topocket(inst, owner)
    if inst._container ~= owner then
        unstore(inst)
        storeincontainer(inst, owner)
    end
end

local function toground(inst)
    unstore(inst)
end

local function simple()
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()

    inst:AddTag("hat")
    inst:AddTag("regerhat")

    anim:SetBank("regerhat")
    anim:SetBuild("hat_regerhat")
    anim:PlayAnimation("anim")

    inst:AddComponent("inspectable")

    if not TheWorld.ismastersim then
        return inst
    end

    inst._container = nil

    inst._oncontainerownerchanged = function(container)
        topocket(inst, container)
    end

    inst._oncontainerremoved = function()
        unstore(inst)
    end

    inst:AddComponent("chosenowner")
    inst.components.chosenowner:SetOwner("reger")

    inst:ListenForEvent("onputininventory", topocket)
    inst:ListenForEvent("ondropped", toground)

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/regerhat.xml"

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD

    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    return inst
end


local function fn()
--雷哥帽子核心代码
    local inst = simple()
    custom_init(inst)

    if not TheWorld.ismastersim then
        return inst
    end

	inst.components.equippable:SetOnEquip(miner_turnon)
	inst.components.equippable:SetOnUnequip(miner_unequip)
	inst:AddComponent("fueled")
	inst.components.fueled:InitializeFuelLevel(TUNING.REGERMAXTIME)

    return inst
end

--[[

local function fn()
--local inst = CreateEntity()
--inst.entity:AddTransform()
--inst.entity:AddAnimState()
--inst.entity:AddNetwork()
--MakeInventoryPhysics(inst)
--inst.isWeared = false
--inst.isDropped = false
--雷哥帽子核心代码
    local inst = simple()
    custom_init(inst)
--雷哥帽子核心代码
	if not TheWorld.ismastersim then
        return inst
    end



--kana帽子A
	--inst.components.inventoryitem:SetOnDroppedFn(ondrop)
	--inst.components.equippable:SetOnEquip(onEquip)
	--inst.components.equippable:SetOnUnequip(onUnEquip)
--kana帽子A

	inst.AnimState:SetBank("headwear2")
	inst.AnimState:SetBuild("headwear2")
	inst.AnimState:PlayAnimation("anim")
	inst:AddComponent("inventoryitem")
	inst:AddComponent("equippable")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/headwear2.xml"
	inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
	
	MakeForgeRepairable(inst, FORGEMATERIALS.headwear2, OnBroken, OnRepaired)---物品损坏和修复
	inst:ListenForEvent("phasechanged", function() saniup(inst) end, TheWorld)
	
    return inst
end
]]--


return Prefab("common/inventory/headwear2", fn)