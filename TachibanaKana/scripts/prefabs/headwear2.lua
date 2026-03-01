----回复精神值带上后的各种buff
local FIXED_SANITY_COST = 10 ---制作物品消耗10点理智
local function saniup(inst)
	if inst.isWeared and not inst.isDropped then
		inst.components.equippable.dapperness = 0.1---回复精神值
		inst:AddComponent("waterproofer")---加入防水能力
		inst.components.waterproofer:SetEffectiveness(1)---防水百分比
		inst:AddComponent("insulator")---加入隔热能力
		if "summer"=="summer" then  
			inst.components.insulator:SetSummer()
		else 
			inst.components.insulator:SetWinter()
		end	
		inst.components.insulator:SetInsulation(280)---隔热持续时间
		inst:AddComponent("armor")---加入护甲能力
		---inst.components.armor:InitCondition(10000000000, 0.5) --- 让头盔有使用次数和防御比列
		inst:AddTag("hide_percentage")--隐藏耐久
		inst.components.armor:InitIndestructible(0.8)---只有防御没有耐久
		  -- ========== 新增：20点位面防御 ==========
		 -- ========== 20点位面防御（和武器位面伤害写法一致） ==========
        --if not inst:HasComponent("planardefense") then
            inst:AddComponent("planardefense") -- 添加位面防御组件
       -- end
        inst.components.planardefense:SetBaseDefense(15) -- 设置20点位面防御
	
	end
end

--带上后改变身体大小
local function sizechange(owner, current, increment, final, overtime, boost)
	if owner.expand == nil then
		if owner.components.combat.damagemultiplier == nil then
			owner.components.combat.damagemultiplier = 1
		end
		owner.expand = owner:DoPeriodicTask(overtime, 
		function()
			owner.components.combat.damagemultiplier = owner.components.combat.damagemultiplier + boost---伤害加
			--owner.components.hunger.hungerrate = owner.components.hunger.hungerrate + (boost * 0.5)---饥饿加
			owner.expand:Cancel()
			owner.expand = nil
		end)
	end
end




local function onequip(inst, owner, symbol_override) --共用
--检测人物名称是否有kana  if inst.prefab == "kana" then

	owner.AnimState:OverrideSymbol("swap_hat", "headwear2", "swap_hat")
	owner.AnimState:Show("HAT")
	owner.AnimState:Show("HAT_HAIR")
	-- 定义固定消耗的理智值（方便后续调整）
	if owner:HasTag("player") then	
		-- 标记装备状态
		inst.isWeared = true
		inst.isDropped = false
		inst.buildmaster = true
		  -- 1. 材料消耗减半
    if owner and owner.components.builder ~= nil then
        owner.components.builder.ingredientmod = 0.5
    end
	
	 -- 2. 保存原始的MakeRecipe方法，用于重写
    if owner and owner.components.builder and not owner.components.builder.OriginalMakeRecipe then
        owner.components.builder.OriginalMakeRecipe = owner.components.builder.MakeRecipe
        
        -- 重写MakeRecipe方法，添加固定理智消耗
        owner.components.builder.MakeRecipe = function(self, recipe, pt, onsuccess, soundoverride, nosound)
            -- 先执行原始的制作逻辑（包括材料消耗减半）
            local success = self:OriginalMakeRecipe(recipe, pt, onsuccess, soundoverride, nosound)
            
            -- 只有制作成功时，才扣除固定理智
            if success and self.inst and self.inst.components.sanity then
                -- 计算扣除后的理智值（避免扣到负数）
                local new_sanity = self.inst.components.sanity.current - FIXED_SANITY_COST
                self.inst.components.sanity.current = math.max(new_sanity, 0)
                
                -- 可选：添加提示文字，告知玩家消耗了理智
                if self.inst.components.talker then
                    self.inst.components.talker:Say("制作消耗了10点理智！")
                end
            end
            
            return success
        end
    end

		---带上后身体变大
		local nx, ny, nz = owner.Transform:GetScale()
		sizechange(owner, {nx, ny, nz}, nx/8, {nx*1.25, ny*1.25, nz*1.25}, .25, 0.8)
		owner.sg:GoToState("powerup")---变大动画 解决了bug 变小动画不用加 因为加了会下地洞卡服务器 下地洞会触发头盔失效的函数其中owner.sg:GoToState("powerdown")就会导致服务器崩溃
		---这段代码是变大动画 解决bug 
		owner.Transform:SetScale(nx*1.25, ny*1.25, nz*1.25)
		saniup(inst)
	end
--kana代码
	
end

local function onunequip(inst, owner)  --共用
--雷哥代码
    owner.AnimState:ClearOverrideSymbol("swap_hat")
    owner.AnimState:Hide("HAT")
    owner.AnimState:Hide("HAIR_HAT")
    owner.AnimState:Show("HAIR_NOHAT")
    owner.AnimState:Show("HAIR")
    if owner:HasTag("player") then
        owner.AnimState:Show("HEAD")
        owner.AnimState:Hide("HEAD_HAT")
    end
--雷哥代码

--kana代码
	if owner:HasTag("player") then
		--制作减半
		inst.isWeared = false
		inst.isDropped = false
		inst.buildmaster = false
		-- 还原材料消耗倍率
		if owner and owner.components.builder ~= nil then
			owner.components.builder.ingredientmod = 1.0
		end
		
		 -- 还原原始的MakeRecipe方法
		if owner and owner.components.builder and owner.components.builder.OriginalMakeRecipe then
			owner.components.builder.MakeRecipe = owner.components.builder.OriginalMakeRecipe
			owner.components.builder.OriginalMakeRecipe = nil
		end
		
		
		---带上后身体变大
		local nx, ny, nz = owner.Transform:GetScale()
		sizechange(owner, {nx, ny, nz}, -nx/5, {nx*0.8, ny*0.8, nz*0.8}, .25, -0.8)
		--owner.sg:GoToState("powerdown")---变小动画 bug源头
		---这段代码是变大动画 解决bug 
		owner.Transform:SetScale(1, 1,1)	
		saniup(inst)
	end
--kana代码
	
end


local function miner_turnon(inst)
    local owner = inst.components.inventoryitem ~= nil and inst.components.inventoryitem.owner or nil
	--[[
	--检测帽子的耐久度
    if not inst.components.fueled:IsEmpty() then 
	  --如果还有耐久度就继续
	elseif owner ~= nil then--如果没有耐久度 就会出发如下
        onequip(inst, owner, "swap_hat_off")
    end
	--检测帽子的耐久度
	]]--
	--检测人物名称是否有kana  if inst:HasTag("kana")
	--这个代码如果有人带上这个帽子就拥有如下技能  if owner ~= nil then
	if owner ~= nil   then
		--owner:AddTag("regerbomb")--拥有这个tag regerbomb才能戴帽子放炮
		onequip(inst, owner)
	end
	
	local soundemitter = owner ~= nil and owner.SoundEmitter or inst.SoundEmitter
	soundemitter:PlaySound("dontstarve/common/minerhatAddFuel")
	
		
    
end

local function miner_turnoff(inst)
    local owner = inst.components.inventoryitem ~= nil and inst.components.inventoryitem.owner or nil
    if owner ~= nil and inst.components.equippable ~= nil and inst.components.equippable:IsEquipped() then
        owner:RemoveTag("regerbomb")
        onequip(inst, owner, "swap_hat_off")
    end
end

local function miner_unequip(inst, owner)
    --owner:RemoveTag("regerbomb")--拥有这个tag regerbomb才能戴帽子放炮
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
	
    inst:AddTag("regerhat")--必须是regerhat否则显示不正常
    anim:SetBank("headwear2")--必须是headwear2否则王冠丢地上会消失但是可以拾取
	
    anim:SetBuild("headwear2")
    anim:PlayAnimation("anim")

--AddComponent(...)：是实体的一个方法，用于给实体「挂载组件」。组件（Component）是饥荒中模块化设计的核心，
--每个组件负责实体的一种特定功能（比如战斗、发光、储存等）。
--"inspectable"：是组件的名称，直译是「可检查的」。
--inst:AddComponent("inspectable")

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

    --inst:AddComponent("chosenowner")--物品归属功能chosenowner 这个物品只能某个人可以使用 chosenowner.lua
    --inst.components.chosenowner:SetOwner("reger")

    inst:ListenForEvent("onputininventory", topocket)
    inst:ListenForEvent("ondropped", toground)

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/headwear2.xml"

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
--雷哥帽子核心代码
    if not TheWorld.ismastersim then
        return inst
    end
   -- inst.components.inventoryitem:SetOnDroppedFn(miner_turnoff)
   inst.components.equippable:SetOnEquip(miner_turnon)--这个是带上头盔后拥有火葬炮的关键
   inst.components.equippable:SetOnUnequip(miner_unequip)
   inst:AddComponent("fueled")
    --inst.components.fueled.fueltype = FUELTYPE.CAVE
   inst.components.fueled:InitializeFuelLevel(TUNING.REGERMAXTIME)
   -- inst:AddComponent("waterproofer")
   -- inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_SMALL)
   -- inst._light = nil
   -- inst.OnRemoveEntity = miner_onremove
    return inst
end


return Prefab("common/inventory/headwear2", fn)