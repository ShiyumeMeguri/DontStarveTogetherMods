local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
	
	--Asset("Stategraph", "scripts/stategraphs/SGwilson.lua"),
	Asset("SCRIPT", "scripts/prefabs/stalker_berry.lua"),
	Asset("SCRIPT", "scripts/prefabs/stalker_bulb.lua"),
	Asset("SCRIPT", "scripts/prefabs/stalker_ferns.lua"),
	
	
	Asset( "IMAGE", "images/map_icons/kana.tex" ),--小地图
	Asset( "ATLAS", "images/map_icons/kana.xml" ),--小地图
	
	Asset( "IMAGE", "images/avatars/avatar_kana.tex" ),--tab键人物列表显示的头像
    Asset( "ATLAS", "images/avatars/avatar_kana.xml" ),--tab键人物列表显示的头像
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_kana.tex" ),--tab键人物列表显示的头像（死亡）
    Asset( "ATLAS", "images/avatars/avatar_ghost_kana.xml" ),--tab键人物列表显示的头像（死亡）
	
	Asset( "IMAGE", "images/avatars/self_inspect_kana.tex" ),--人物检查按钮的图片
    Asset( "ATLAS", "images/avatars/self_inspect_kana.xml" ),--人物检查按钮的图片
	
	Asset( "IMAGE", "images/names_kana.tex" ),  --人物名字
    Asset( "ATLAS", "images/names_kana.xml" ),  --人物名字
	
	-- Asset("SOUND", "sound/willow.fsb"),--人物声音
	--Asset("ANIM", "anim/player_idles_wortox.zip"),--人物  恶魔人普通待机动作
	 Asset("ANIM", "anim/wortox_soul_ball.zip"), --人物  恶魔人拥有灵魂特殊待机动作 VFX for idle_naughty.
	
}


--AddModCharacter("kana", "FEMALE")

-- Custom starting inventory
TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.whorl = {
	"shadowheart",
}

local BLOOM_CHOICES =
{
    ["stalker_bulb"] = 1,
    ["stalker_bulb_double"] = 1,
    ["stalker_berry"] = 3,
    ["stalker_fern"] = 5,
}

local STALKERBLOOM_TAGS = { "stalkerbloom" }

local function DoPlantBloom(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local map = TheWorld.Map
    local offset = FindValidPositionByFan(
        math.random() * 2 * PI,
        math.random() * 3,
        8,
        function(offset)
            local x1 = x + offset.x
            local z1 = z + offset.z
            return map:IsPassableAtPoint(x1, 0, z1)
                and map:IsDeployPointClear(Vector3(x1, 0, z1), nil, 1)
                and #TheSim:FindEntities(x1, 0, z1, 2.5, STALKERBLOOM_TAGS) < 4
        end
    )

    if offset ~= nil then
        SpawnPrefab(weighted_random_choice(BLOOM_CHOICES)).Transform:SetPosition(x + offset.x, 0, z + offset.z)
    end
end

local function OnStartBlooming(inst)
    --DoTrail(inst)
    inst._bloomtask = inst:DoPeriodicTask(40 * FRAMES, DoPlantBloom, 2 * FRAMES)
end

local function _StartBlooming(inst)
	if inst._bloomtask == nil then
		inst._blooming = true
        inst._bloomtask = inst:DoTaskInTime(0, OnStartBlooming)
    end
end

local function StopBlooming(inst)
    if inst._blooming then
        inst._blooming = false
        if inst._bloomtask ~= nil then
			inst._bloomtask:Cancel()
			inst._bloomtask = nil
		end
		--[[if inst._trailtask ~= nil then
			inst._trailtask:Cancel()
			inst._trailtask = nil
		end]]
    end
end

local function Checktime(inst)
	if TheWorld.state.phase == "day" then
		StopBlooming(inst)--Player has either recently become deceased or else the sun has risen
		inst.components.sanity.dapperness = -(1/16)
	elseif TheWorld.state.phase == "dusk" then
		StopBlooming(inst)--Player has either recently become deceased or else the sun has risen
		inst.components.sanity.dapperness = (1/2)
	elseif TheWorld.state.phase == "night" then 
		inst.components.sanity.dapperness = (1/2)
		if not inst:HasTag("cavernous") and not inst:HasTag("ancient") and not inst:HasTag("playerghost") and not TheWorld:HasTag("cave") then
			_StartBlooming(inst) --Begin blooming process if in forest mode, it's night and you're alive
		end
	end
end

----------------------------------------------------------------------------------------------------------------------
---触发暴击的概率暂时不用
--local function onattacksss(inst, data)---触发暴击的概率
   
 --   local victim = data.target
 --   local item = data.weapon
  --  if item and item.components.weapon and 
   --     math.random() < 0.5 and
    --    victim and victim.components.health and not victim.components.health:IsDead() and 
    --    victim.components.health.absorb ~= 0 then
        --local amount = item.components.weapon.damage * inst.components.combat.damagemultiplier * victim.components.health.absorb
	--	local amount = 1000
   --     victim.components.health:DoDelta(-amount, nil, nil, nil, nil, true)
   --     SpawnPrefab("explode_small").Transform:SetPosition(victim.Transform:GetWorldPosition())
 --   end
--end
---触发暴击的概率暂时不用


---时间管理旺达能力 函数
--[[
local function on_show_warp_marker_kana(inst)
	inst.components.positionalwarp:EnableMarker(true)
end

local function on_hide_warp_marker_kana(inst)
	inst.components.positionalwarp:EnableMarker(false)
end

local function OnWarpBack_kana(inst, data)
	if inst.components.positionalwarp ~= nil then
		if data ~= nil and data.reset_warp then
			inst.components.positionalwarp:Reset()
		else
			inst.components.positionalwarp:GetHistoryPosition(true)
		end
	end
end
]]--
--时间管理旺达能力 函数

---老麦能力函数
local function WaxwellDoEffects(pet)
    local x, y, z = pet.Transform:GetWorldPosition()
    SpawnPrefab("statue_transition_2").Transform:SetPosition(x, y, z)
end

local function WaxwellKillPet(pet)
    pet.components.health:Kill()
end

local function WaxwellOnDespawnPet(inst, pet)
    if pet:HasTag("shadowminion") then
        WaxwellDoEffects(pet)
        pet:Remove()

    elseif inst._OnDespawnPet ~= nil then
        inst:_OnDespawnPet(pet)
    end
end

local function WaxwellOnDeath(inst)
    if inst.components.petleash:GetPets() then
        for k, v in pairs(inst.components.petleash:GetPets()) do
            if v:HasTag("shadowminion") and v._killtask == nil then
                v._killtask = v:DoTaskInTime(math.random(), WaxwellKillPet)
            end
        end
    end
end

local function WaxwellOnReroll(inst)
    local todespawn = {}
    for k, v in pairs(inst.components.petleash:GetPets()) do
        if v:HasTag("shadowminion") then
            table.insert(todespawn, v)
        end
    end
    for i, v in ipairs(todespawn) do
        inst.components.petleash:DespawnPet(v)
    end
end
---老麦能力函数

return MakePlayerCharacter("kana", {}, {}, 
function(inst) 
	inst.MiniMapEntity:SetIcon( "kana.tex" )
	inst:AddTag("kana_build")
	inst:AddTag("reger")
	inst:AddTag("regerbomb")--拥有这个标签 regerbomb  才能戴帽子放炮
	inst.soundsname = "Wendy"--- 定义人物的声音系统 是饥荒人物或者自己做的
	inst.customidleanim = "idle_naughty"
	--定义人物默认动作系统 目前用的是恶魔人的 拥有灵魂的待机动作- 恶魔人比较特殊 有2个动作
	--默认情况下 这个动作 手里没有灵魂特效  所以必须在上面加上这个  
	-- Asset("ANIM", "anim/wortox_soul_ball.zip"), --人物  恶魔人拥有灵魂特殊待机动作 VFX for idle_naughty.
	--inst.customidleanim = "idle_warly" --定义人指定某个人物的待机动作
	
	
	inst:AddTag("mastercookware")---大厨能力标签
	
	
	----角色待机姿势
	inst.AnimState:PlayAnimation("idle_loop", true)
	
	
	---时间管理旺达能力 
	---inst:AddTag("clockmaker")
	---inst:AddTag("pocketwatchcaster")
	
	---时间管理旺达能力 
	
	---可以使用弹弓
--inst:AddTag("pebblemaker")--鹅卵石制造者
	 --inst:AddTag("expertchef")--专家厨师
    --inst:AddTag("pinetreepioneer")--松树先锋
    --inst:AddTag("slingshot_sharpshooter")---可以使用弹弓
    --inst:AddTag("efficient_sleeper")--高效睡眠
   -- inst:AddTag("dogrider")--可以骑狗
    --inst:AddTag("nowormholesanityloss")--无虫洞理智损失
	--inst:AddTag("storyteller") -- 可以讲故事 
	

---拥有老麦的能力---
--inst:AddTag("magician")
--inst:AddTag("reader")
inst:AddTag("shadowmagic")
--inst:AddTag("dappereffects")
--inst:AddTag("achivbookbuilder")---暗影秘典制造者
--inst:AddTag("achivshadowmagicbuilder") ---暗影空间制造者
---拥有老麦的能力


---快速采集和制作
inst:AddTag("fastpicker")--快速收集
inst:AddTag("fastharvester") --快速收获
--inst:AddTag("fastbuilder")--快速制造
--inst:AddTag("achivehandyperson")--快速
---快速采集和制作

--模组联动 可以使用 bamboooo 人物的  锅  作者作品地址是//https://steamcommunity.com/sharedfiles/filedetails/?id=1537667891&searchtext=bamboo
--inst:AddTag("bamboooo")----模组联动 可以使用 bamboooo 人物的  锅  作者作品地址是//https://steamcommunity.com/sharedfiles/filedetails/?id=1537667891&searchtext=bamboo
--inst:AddTag("riko")----模组联动 可以使用 bamboooo 人物的  锅  作者作品地址是//https://steamcommunity.com/sharedfiles/filedetails/?id=1537667891&searchtext=bamboo



---大力士重物不减速
--if not TheWorld.ismastersim then return end
---植物人
inst:AddTag("plantkin") --植物金
inst:AddTag("healonfertilize")--治癒施肥
inst:AddTag("farmplantidentifier")--农场植物标识符
inst:AddTag("saplingcrafter") --树苗制作者
--inst:AddTag("berrybushcrafter")--浆果灌木工匠
--inst:AddTag("juicyberrybushcrafter") -- 多汁浆果丛林工匠
--inst:AddTag("reedscrafter") --芦苇工匠
--inst:AddTag("lureplantcrafter") --诱饵植物工匠
--inst:AddTag("syrupcrafter") ---糖浆制作师
--inst:AddTag("lightfliercrafter")--輕型飛行工匠
--inst:AddTag("carratcrafter")--卡拉特工匠
--inst:AddTag("fruitdragoncrafter")--水果龍工匠
---植物人



end,
function(inst)

	---大力士重物不减速
	--if not inst.components.mightiness then
	--inst:AddComponent("mightiness")
	--end
	--inst.components.mightiness.current = inst.components.mightiness.max
	--inst.components.mightiness.state = "mighty"
	--inst.components.mightiness.CanTransform = function() return false end
	--inst.components.mightiness.GetPercent = function() return 1 end
	--inst.components.mightiness.DoDelta = function() end
	---大力士重物不减速
	--万达 
	--inst:AddComponent("positionalwarp")--位置扭曲-- 别用 会上船崩溃
	--万达 
	---食物能力
inst.components.eater.ignoresspoilage = true  -- 无视食物腐烂（吃变质/腐烂食物无惩罚）
--inst.components.eater.strongstomach = true -- 解锁吃怪物肉的能力（不会掉血/掉san值）
--inst.components.eater:SetDiet({ FOODGROUP.OMNI }, { FOODGROUP.OMNI }) -- 全食物兼容（能吃所有类型食物）
--inst.components.eater.preferseatingtags = nil -- 清除饮食偏好（无食物类型偏好）
--inst:RemoveComponent("foodmemory") -- 移除食物记忆组件（重复吃同一种食物不会降低收益）


	inst.components.health:SetAbsorptionAmount(0.5)  ----自带防御50%
	inst.components.health:SetMaxHealth(300)--500血量
	inst.components.hunger:SetMax(800)--500饥饿
	inst.components.sanity:SetMax(500)--100精神
	
	--2025 10 14 雷古 火葬炮 能力导入 这个 regerweapon.lua是火葬炮必须的炮弹效果 必须在kana.lua里面载入这个 -- 生成角色专属武器（挂载为角色子实体）
	--意思是 regerweapon.lua在文件\scripts\prefabs\regerweapon.lua下面
    inst.regerweapon = SpawnPrefab("regerweapon")
    inst.regerweapon.entity:SetParent(inst.entity)
	--2025 10 14 雷古 火葬炮 能力导入 这个 regerweapon.lua是火葬炮必须的炮弹效果 必须在kana.lua里面载入这个 -- 生成角色专属武器（挂载为角色子实体）
	
	
	
	--inst.components.health:StartRegen(1,5)-- -- Start health regen 每3秒回血1
	
	
	
	---火焰对自己伤害为0
	inst.components.health.fire_damage_scale = 0
	---攻击力倍率是1.5
	---失效inst.components.combat:SetDefaultDamage(TUNING.UNARMED_DAMAGE * 2)
	---失效inst.components.combat.playerdamagepercent = TUNING.UNARMED_DAMAGE * 2
	inst.components.combat.damagemultiplier = 1.25---攻击力倍率是1.25
	---inst:ListenForEvent("onattackother", onattack)  暴击补正函数 因为三叉戟而放弃使用

		--unlock all recipes!隐藏科技 
	inst:AddComponent("positionalwarp")
	inst:AddComponent("reader")--可以读取魔法书
	inst:AddComponent("magician")--可以用暗影魔法 
	--inst:AddComponent("aab_waxwell")--麦斯威尔能力
	inst.components.petleash:SetMaxPets(inst.components.petleash:GetMaxPets() + 71)--这个代码可以直接控制召唤老麦影子的数量 我设定是72个 
	
	-- Movement speed (optional)走路速度和奔跑速度
	inst.components.locomotor.walkspeed = 7---普通速度
	inst.components.locomotor.runspeed = 7---普通速度
	
	inst.components.builder.science_bonus = 3---科技等级
	inst.components.builder.magic_bonus = 3---科技等级
	inst.components.builder.ancient_bonus = 4---科技等级
	
	-----启动特殊能力函数在这里  上面启动有问题
	inst:WatchWorldState("phase",Checktime)
	-----启动特殊能力函数在这里  上面启动有问题   armordreadstone
end, 
{
"yellowamulet",
"moonstorm_goggleshat_blueprint",
"deserthat_blueprint",
"chestupgrade_stacksize_blueprint",
"trident_blueprint",
"bundlewrap_blueprint",
"carpentry_station_blueprint",
"winch_blueprint",
"thulecitebugnet_blueprint",
"refined_dust_blueprint",
"archive_resonator_item_blueprint",
"moon_device_construction1_blueprint",

"dreadstonehat_blueprint",
"armordreadstone_blueprint",
"fence_electric_item_blueprint",
"cotl_tabernacle_level1_blueprint",

})