GLOBAL.setmetatable(env,{ __index = function(t,k) return GLOBAL.rawget(GLOBAL,k) end })

----卡尼猫代码
local _G = GLOBAL
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH

local function oncurrentmissactioning(self,missactioning) self.inst.cmissactioning:set(missactioning) end



---需要载入的其他功能性的 lua函数
PrefabFiles = {
	"kana",--人物属性 scripts\prefabs\kana.lua
	"headwear",--原版的发卡 scripts\prefabs\headwear.lua
	"headwear2",--勤俭王冠 scripts\prefabs\headwear2.lua
	"super_atk_fx_kana",----跳劈代码 scripts\prefabs\super_atk_fx_kana.lua
	"achivbooks_add_kana",---额外的书魔法 scripts\prefabs\achivbooks_add_kana.lua
	"shadowmeteor_ai_kana",---陨石雨 scripts\prefabs\shadowmeteor_ai_kana.lua
	
	--雷哥火葬炮
	"regerweapon",--引用火葬炮的炮弹必须有 在scripts\prefabs\regerweapon.lua里面
	"reger_projectile",---雷哥火葬炮必须的否则射空气
	--雷哥火葬炮
}


Assets = {
	Asset( "ANIM","anim/kana.zip" ),
	Asset( "ANIM","anim/ghost_kana_build.zip" ),
	
    Asset( "IMAGE","images/saveslot_portraits/kana.tex" ),--存档图片
    Asset( "ATLAS","images/saveslot_portraits/kana.xml" ),--存档图片

    Asset( "IMAGE","images/selectscreen_portraits/kana.tex" ),---选人界面
    Asset( "ATLAS","images/selectscreen_portraits/kana.xml" ),--选人界面
	
    Asset( "IMAGE","images/selectscreen_portraits/kana_silho.tex" ),--解锁界面
    Asset( "ATLAS","images/selectscreen_portraits/kana_silho.xml" ),--解锁界面

    Asset( "IMAGE","bigportraits/kana.tex" ),
    Asset( "ATLAS","bigportraits/kana.xml" ),
	
	Asset( "IMAGE","images/map_icons/kana.tex" ),--小地图
	Asset( "ATLAS","images/map_icons/kana.xml" ),--小地图
	
	Asset( "IMAGE","images/avatars/avatar_kana.tex" ),--tab键人物列表显示的头像
    Asset( "ATLAS","images/avatars/avatar_kana.xml" ),--tab键人物列表显示的头像
	
	Asset( "IMAGE","images/avatars/avatar_ghost_kana.tex" ),--tab键人物列表显示的头像（死亡）
    Asset( "ATLAS","images/avatars/avatar_ghost_kana.xml" ),--tab键人物列表显示的头像（死亡）
	
	Asset( "IMAGE","images/avatars/self_inspect_kana.tex" ),--人物检查按钮的图片
    Asset( "ATLAS","images/avatars/self_inspect_kana.xml" ),--人物检查按钮的图片
	
	Asset( "IMAGE","images/names_kana.tex" ), --人物名字
    Asset( "ATLAS","images/names_kana.xml" ), --人物名字
	
    Asset( "IMAGE","bigportraits/kana_none.tex" ),
    Asset( "ATLAS","bigportraits/kana_none.xml" ),

	
	
	Asset( "ANIM","anim/headwear.zip" ),
	Asset( "ATLAS","images/inventoryimages/headwear.xml"),
	
	Asset("ANIM","anim/headwear2.zip" ),
	Asset("ATLAS","images/inventoryimages/headwear2.xml"),
	
	Asset( "ANIM","anim/player_jump.zip" ),

}


local cst = GLOBAL.STRINGS.CARNEYSTRINGS

STRINGS.CHARACTER_TITLES.kana = "k...si...i"
STRINGS.CHARACTER_NAMES.kana = "Kana"
STRINGS.CHARACTER_DESCRIPTIONS.kana = "原版设定*Poor person\n*Have a dedicated keyboard\n*Take medicine to survive\n*被原作者遗弃的未完成品\n*我很喜欢所以继续更新强化了能力"
STRINGS.CHARACTER_QUOTES.kana = "\"Kana 橘佳奈\""

STRINGS.NAMES.KANA = "Kana 橘佳奈"

STRINGS.NAMES.KUSURI = "薬 药"
STRINGS.RECIPE_DESC.KUSURI = "生きたいなら　作る ; 生死看淡"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KUSURI = "このmodまだ完成しない。; 这个mod还没完成。"

STRINGS.NAMES.HEADWEAR = "Headwear"
STRINGS.RECIPE_DESC.HEADWEAR = "佳奈ちゃんのヘッドウェア ; 佳奈的头套"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HEADWEAR = "普通のヘッドウェアです。普通的头套。"

STRINGS.NAMES.HEADWEAR2 = "勤节王冠"------这里给装备命名
STRINGS.RECIPE_DESC.HEADWEAR2 = "王冠是天上掉下来的 不知道制作工艺 也无法分解,神赐予的王冠 可以节约材料消耗！"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HEADWEAR2 = "王冠是天上掉下来的 不知道制作工艺 也无法分解"


STRINGS.NAMES.ACHIVBOOK_METEOR_KANA = "自杀流星雨"
STRINGS.RECIPE_DESC.ACHIVBOOK_METEOR_KANA = "自杀流星雨"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ACHIVBOOK_METEOR_KANA = "自杀流星雨。"

STRINGS.NAMES.ACHIVBOOK_SHAKESPEARE_KANA = "石化林"
STRINGS.RECIPE_DESC.ACHIVBOOK_SHAKESPEARE_KANA = "石化林！"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ACHIVBOOK_SHAKESPEARE_KANA = "石化树林。"

STRINGS.NAMES.ACHIVBOOK_METEOR2_KANA = "自杀流星雨"
STRINGS.RECIPE_DESC.ACHIVBOOK_METEOR2_KANA = "自杀流星雨"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ACHIVBOOK_METEOR2_KANA = "自杀流星雨"

STRINGS.NAMES.ACHIVBOOK_SHAKESPEARE2_KANA = "石化林"
STRINGS.RECIPE_DESC.ACHIVBOOK_SHAKESPEARE2_KANA = "石化林！"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ACHIVBOOK_SHAKESPEARE2_KANA = "石化林。"


STRINGS.CHARACTERS.KANA = require "speech_wortox"---说话台词 选的是恶魔人  你可以根据情况选择其他人物 名称必须对
AddMinimapAtlas("images/map_icons/kana.xml")
AddModCharacter("kana","FEMALE")---性别


--TUNING.kana_DodgeKey = GetModConfigData('kana_DodgeKey')---跳跃代码按键---这个是获取了 maininfo里面的代码的configuration_options 参数

-- 工具熊之力-- 工具熊之力-- 工具熊之力-- 工具熊之力-- 工具熊之力-- 工具熊之力-- 工具熊之力-- 工具熊之力-- 工具熊之力-- 工具熊之力-- 工具熊之力
------震荡波代码 模拟工具熊 scripts\components\tool_bearger.lua
---根据我的推算  inst:AddComponent("tool_bearger") 这个意思就是载入 这个文件夹下面的脚本 scripts\components\tool_bearger.lua
---而下面的这个  inst.components.tool_bearger.意思就是调用 这个脚本里面的函数
if TheNet and TheNet:GetIsServer()  then----这段代码表示必须是kana名称的人物才能用这个跳劈then
    AddPlayerPostInit(function(inst)
			inst:DoTaskInTime(1,function()
				if not inst.components.tool_bearger then
					-- 模拟工具熊
					inst:AddComponent("tool_bearger")-----刺激！！ 加入 加了 tool_bearger.lua  
					inst.components.tool_bearger.destroyer = true
					inst.components.tool_bearger.damageRings = 2
					inst.components.tool_bearger.destructionRings = 2
					inst.components.tool_bearger.platformPushingRings = 2
					inst.components.tool_bearger.numRings = 3
					-- 破坏范围
					inst.components.tool_bearger.damageRanage = 6
				end
			end)
		
    end)
end

AddModRPCHandler("efficiency","pick",function(player) 
    player.components.range_operation:RangePick()
end)

AddModRPCHandler("efficiency","collection",function(player) 
    player.components.range_operation:RangeCollection()
end)

AddModRPCHandler("efficiency","bearger",function(player) 
    player.components.tool_bearger:GroundPound()
end)


TUNING.BEARGER_POWER_FUN = GetModConfigData("bearger_oper")---这个是获取了 maininfo里面的代码的configuration_options 参数
TUNING.BEARGER_POWER_KEY = GetModConfigData("bearger_power")---获取默认按键 ---这个是获取了 maininfo里面的代码的configuration_options 参数
TUNING.RANGE_BEARPOWER_HUNGER = -20--------- 震荡波 耗费10点饥饿
TUNING.kana_Super_Atk = GetModConfigData('kana_Super_Atk')---跳劈代码按键---这个是获取了 maininfo里面的代码的configuration_options 参数


--雷古帽子次数
TUNING.REGERMAXTIME = 9999999
TUNING.REGBOMB_DAMAGE = 1000
--雷古帽子次数


local function IsDefaultScreen()
	if TheFrontEnd:GetActiveScreen() and TheFrontEnd:GetActiveScreen().name and 
    type(TheFrontEnd:GetActiveScreen().name) == "string" and TheFrontEnd:GetActiveScreen().name == "HUD" then
		return true
	else
		return false
	end
end


TheInput:AddKeyUpHandler(TUNING.BEARGER_POWER_KEY,
	function() 
		if TheNet and TheNet:GetIsClient() and not IsDefaultScreen() then return end
		if TheNet and TheNet:GetIsServer() and not IsDefaultScreen() then return end----IsDefaultScreen需要函数
		if TUNING.BEARGER_POWER_FUN then
			SendModRPCToServer(MOD_RPC["efficiency"]["bearger"])
		end
end)
----震荡波代码

-- 工具熊之力-- 工具熊之力-- 工具熊之力-- 工具熊之力-- 工具熊之力-- 工具熊之力-- 工具熊之力

-----制作参数声明其中包括了制作这些物品需要的基础物品
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH
local Ingredient = GLOBAL.Ingredient
--Recipe = Class(function(self,name,ingredients,tab,level,placer,min_spacing,nounlock,numtogive,builder_tag,atlas,image,testfn,product)
--Recipe item 配方
------------制作物品的牛逼函数
local function AddModRecipe(prefab,ingredients,tab,level,someone_build,...)
    return AddRecipe(prefab,ingredients,tab,level,nil,nil,nil,nil,nil)
end

------用了某个大佬做的烹饪锅代码 创意工坊是 workshop-1854353610 ---function 函数 便携锅便携锅便携锅便携锅便携锅便携锅
local function CanUse(inst)
    if inst:HasTag("mastercookware") then
        inst:RemoveTag("mastercookware")
    end

    if not TheWorld.ismastersim then
        return
    end

    if inst.components.prototyper then
        inst.components.prototyper.restrictedtag = "player"
    end
end

local function CanUse_item(inst)
    if inst:HasTag("mastercookware") then
        inst:RemoveTag("mastercookware")
    end

    if not TheWorld.ismastersim then
        return
    end

    if inst.components.deployable then
        inst.components.deployable.restrictedtag = "player"
    end
end



--卡尼猫 改 的 物品制作配方写法 --不影响原版且不和其他同类型冲突  也不会导致读取存档几分钟无法进入游戏的情况 终于解决了巨大的潜在bug ：之前的写法没错但是只是适合 没有配方的物品 如果已经有重复的配方积累多了就会导致游戏后期存档无法读取的情况
--https://steamcommunity.com/sharedfiles/filedetails/?id=2904374520 卡尼猫 改 创意工坊地址 感谢 --作者空间 https://steamcommunity.com/profiles/76561198872538813
--AddRecipe2("carney_something",{Ingredient("papyrus",2),Ingredient("bird_egg",2) },TECH.NONE,{builder_tag="kana_build",product ="carney_something",numtogive = 1},{"CHARACTER"})
--卡尼猫 改 的 物品制作配方写法 --不影响原版且不和其他同类型冲突  也不会导致读取存档几分钟无法进入游戏的情况 



---南瓜 pumpkin
AddRecipe2("pumpkin_kana",{Ingredient("goldnugget",2)},TECH.NONE,{builder_tag="kana_build",product ="pumpkin",numtogive = 1},{"CHARACTER"})

---便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅---便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅
----3个烹饪锅的制作和使用代码 
AddRecipe2("portablecookpot_item_kana",{Ingredient("goldnugget",2),Ingredient("charcoal",6),Ingredient("twigs",6)},TECH.NONE,{builder_tag="kana_build",product ="portablecookpot_item",numtogive = 1},{"CHARACTER"})



AddPrefabPostInit("portablecookpot",CanUse)
AddPrefabPostInit("portablecookpot_item",CanUse_item)

--AddModRecipe("portableblender_item",{Ingredient("goldnugget",2),Ingredient("transistor",2),Ingredient("twigs",4)},RECIPETABS.FARM,TECH.NONE)
AddRecipe2("portableblender_item_kana",{Ingredient("goldnugget",2),Ingredient("transistor",2),Ingredient("twigs",4)},{SCIENCE = 3,MAGIC = 0},{product ="portableblender_item",description = "",numtogive = 1,builder_tag="kana_build"},{"CHARACTER"})--不影响原版可以独立制作
AddPrefabPostInit("portableblender",CanUse)
AddPrefabPostInit("portableblender_item",CanUse_item)

--AddModRecipe("portablespicer_item",{Ingredient("goldnugget",2),Ingredient("cutstone",3),Ingredient("twigs",6)},RECIPETABS.FARM,TECH.NONE)
AddRecipe2("portablespicer_item_kana",{Ingredient("goldnugget",2),Ingredient("cutstone",3),Ingredient("twigs",6)},{SCIENCE = 3,MAGIC = 0},{product ="portablespicer_item",description = "",numtogive = 1,builder_tag="kana_build"},{"CHARACTER"})--不影响原版可以独立制作
AddPrefabPostInit("portablespicer",CanUse)
AddPrefabPostInit("portablespicer_item",CanUse_item)
------用了某个大佬做的烹饪锅代码 创意工坊是 workshop-1854353610

-- 支撑函数
---function 函数

---便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅---便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅---便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅便携锅
---成功了 独立出来了自己的宝石配方 但是 水晶领主依然可以做---成功了 独立出来了自己的宝石配方 但是 水晶领主依然可以做---成功了 独立出来了自己的宝石配方 但是 水晶领主依然可以做
-----AddRecipe2("opalpreciousgemgold",{Ingredient("redgem",1),Ingredient("bluegem",1),Ingredient("greengem",1),Ingredient("purplegem",1),Ingredient("orangegem",1),Ingredient("yellowgem",1)},TECH.MAGIC_TWO,{product ="opalpreciousgem",description = "独角兽独角兽独角兽",numtogive = 1},{"kana_build"})
-----制作宝石代码 不与其他角色冲突


---战斗头盔 可以制作
AddRecipe2("wathgrithrhat_kana",{Ingredient("goldnugget",2),Ingredient("flint",2)},TECH.NONE,{builder_tag="kana_build",product ="wathgrithrhat",numtogive = 1},{"CHARACTER"})
--wathgrithr_improvedhat 统帅头盔
AddRecipe2("wathgrithr_improvedhat_kana",{Ingredient("goldnugget",2),Ingredient("flint",2),Ingredient("marble",1) },TECH.NONE,{builder_tag="kana_build",product ="wathgrithr_improvedhat",numtogive = 1},{"CHARACTER"})
--marble 大理石
AddRecipe2("marble_kana",{Ingredient("cutstone",2)},TECH.NONE,{builder_tag="kana_build",product ="marble",numtogive = 1},{"CHARACTER"})
---荆棘外壳 可以制作
AddRecipe2("armor_bramble_kana",{Ingredient("livinglog",2),Ingredient("stinger",2)},TECH.NONE,{builder_tag="kana_build",product ="armor_bramble",numtogive = 1},{"CHARACTER"})--不影响原版可以独立制作 而且不会和其他同类型配方冲突 
--AddRecipe2("armor_bramble_kana", {Ingredient("livinglog",2),Ingredient("stinger",2)},{ SCIENCE = 3,MAGIC = 0 },{product ="armor_bramble", description = "",numtogive = 1},{"kana_build"})--不影响原版可以独立制作
--卡尼毛的制作配方写法
--AddRecipe2("carney_something",{Ingredient("papyrus",2),Ingredient("bird_egg",2) },TECH.NONE,{builder_tag="kana_build",product ="carney_something",numtogive = 1},{"CHARACTER"})
--卡尼毛的制作配方写法


---联动人物 bamboo 熊猫人 的锅 必须订阅 熊猫人https://steamcommunity.com/sharedfiles/filedetails/?id=1537667891&searchtext=bamboo
--AddRecipe2("bamboo_cookpot_item",{Ingredient("bamboo",4,"images/inventoryimages/bamboo.xml"),Ingredient("cutstone",3),Ingredient("charcoal",6)},TECH.SCIENCE_TWO,{builder_tag = "bamboooo"},{"CHARACTER"})
AddRecipe2("bamboo_cookpot_item_kana",{Ingredient("twigs",4),Ingredient("cutstone",3),Ingredient("charcoal",6)},TECH.NONE,{builder_tag="kana_build",product ="bamboo_cookpot_item",numtogive = 1},{"CHARACTER"})--不影响原版可以独立制作 而且不会和其他同类型配方冲突 
---联动人物 bamboo 熊猫人 的锅 必须订阅 熊猫人https://steamcommunity.com/sharedfiles/filedetails/?id=1537667891&searchtext=bamboo

---联动人物 riko 来自深渊 的锅 必须订阅 https://steamcommunity.com/sharedfiles/filedetails/?id=2938072463&searchtext=riko  或者推荐这个   https://steamcommunity.com/sharedfiles/filedetails/?id=1181077385&searchtext=riko
AddRecipe2("rikocookpot_kana",{Ingredient("twigs",4),Ingredient("cutstone",3),Ingredient("charcoal",6)},TECH.NONE,{builder_tag="kana_build",product ="rikocookpot",numtogive = 1},{"CHARACTER"})--不影响原版可以独立制作 而且不会和其他同类型配方冲突 
---联动人物 riko 来自深渊 的锅 必须订阅 https://steamcommunity.com/sharedfiles/filedetails/?id=2938072463&searchtext=riko  或者推荐这个   https://steamcommunity.com/sharedfiles/filedetails/?id=1181077385&searchtext=riko

--骨头系列--骨头系列--骨头系列--骨头系列
AddRecipe2("houndstooth_kana",{Ingredient("boneshard",10)},TECH.NONE,{builder_tag="kana_build",product ="houndstooth",numtogive = 10},{"CHARACTER"})--10个骨头碎片换10个狗牙
AddRecipe2("boneshard_kana",{Ingredient(CHARACTER_INGREDIENT.HEALTH,50)},TECH.NONE,{builder_tag="kana_build",product ="boneshard",numtogive = 10},{"CHARACTER"})--不影响原版且不和其他同类型冲突 boneshard --自残 5血 变骨头碎片5给
--cutreeds采下的芦苇
AddRecipe2("cutreeds_kana",{Ingredient("cutgrass",1)},TECH.NONE,{builder_tag="kana_build",product ="cutreeds",numtogive = 1},{"CHARACTER"})--不影响原版且不和其他同类型冲突 
---帐篷卷 可以制作
AddRecipe2("portabletent_item_kana",{Ingredient("bedroll_straw",1),Ingredient("twigs",4),Ingredient("rope",2)},TECH.NONE,{builder_tag="kana_build",product ="portabletent_item",numtogive = 1},{"CHARACTER"})--不影响原版且不和其他同类型冲突
---硬木帽 Hardwood Hat 可以制作 6木头 1松果
AddRecipe2("woodcarvedhat_kana",{Ingredient("log",6),Ingredient("cutgrass",1)},TECH.NONE,{builder_tag="kana_build",product ="woodcarvedhat",numtogive = 1},{"CHARACTER"})--不影响原版且不和其他同类型冲突 
---废铁 Scrap 用 电子元件做齿轮
AddRecipe2("gears_kana",{Ingredient("transistor",1)},TECH.NONE,{builder_tag="kana_build",product ="gears",numtogive = 1},{"CHARACTER"})--不影响原版且不和其他同类型冲突 
---吴迪制造树精守卫雕像
AddRecipe2("leif_idol_kana",{Ingredient("livinglog",2),Ingredient("cutgrass",3),Ingredient(CHARACTER_INGREDIENT.HEALTH,100)},TECH.NONE,{builder_tag="kana_build",product ="leif_idol",numtogive = 1},{"CHARACTER"})--不影响原版且不和其他同类型冲突 
---噩梦制造 10精神1 暗影燃料
AddRecipe2("nightmarefuel_kana",{Ingredient(CHARACTER_INGREDIENT.SANITY,50)},TECH.NONE,{builder_tag="kana_build",product ="nightmarefuel",numtogive = 5},{"CHARACTER"})--不影响原版且不和其他同类型冲突 
---灵魂制造 20血量1个 血魂
AddRecipe2("wortox_soul_kana",{Ingredient(CHARACTER_INGREDIENT.SANITY,50)},TECH.NONE,{builder_tag="kana_build",product ="wortox_soul",numtogive = 5},{"CHARACTER"})--不影响原版且不和其他同类型冲突 
---余烬制造 暗影燃料 转换 5个余烬
AddRecipe2("willow_ember_kana",{Ingredient("nightmarefuel",2)},TECH.NONE,{builder_tag="kana_build",product ="willow_ember",numtogive = 6},{"CHARACTER"})--不影响原版且不和其他同类型冲突 

AddRecipe2("redgem_kana",{Ingredient("bluegem",2)},TECH.NONE,{builder_tag="kana_build",product ="redgem",numtogive = 1},{"CHARACTER"})--不影响原版且不和其他同类型冲突 
AddRecipe2("bluegem_kana2",{Ingredient("goldnugget",2),Ingredient("nightmarefuel",2),Ingredient("moonrocknugget",2)},TECH.NONE,{builder_tag="kana_build",product ="bluegem",numtogive = 1},{"CHARACTER"})--不影响原版且不和其他同类型冲突 
AddRecipe2("yellowgem_kana",{Ingredient("purplegem",2)},TECH.NONE,{builder_tag="kana_build",product ="yellowgem",numtogive = 1},{"CHARACTER"})--不影响原版且不和其他同类型冲突 
AddRecipe2("orangegem_kana",{Ingredient("yellowgem",2)},TECH.NONE,{builder_tag="kana_build",product ="orangegem",numtogive = 1},{"CHARACTER"})--不影响原版且不和其他同类型冲突 
AddRecipe2("greengem_kana",{Ingredient("orangegem",2)},TECH.NONE,{builder_tag="kana_build",product ="greengem",numtogive = 1},{"CHARACTER"})--不影响原版且不和其他同类型冲突 
--ancienttree_seed 惊喜种子
AddRecipe2("ancienttree_seed_kana",{Ingredient("opalpreciousgem",1)},TECH.NONE,{builder_tag="kana_build",product ="ancienttree_seed",numtogive = 1},{"CHARACTER"})--不影响原版且不和其他同类型冲突
--彩虹宝石  bookstation
AddRecipe2("opalpreciousgem_kana",{Ingredient("redgem",2),Ingredient("bluegem",2),Ingredient("goldnugget",2),Ingredient("purplegem",2),Ingredient("yellowgem",2),Ingredient("orangegem",2),Ingredient("greengem",2)},TECH.NONE,{builder_tag="kana_build",product ="opalpreciousgem",numtogive = 1},{"CHARACTER"})--不影响原版且不和其他同类型冲突 
---制作铥矿碎片
AddRecipe2("thulecite_pieces_kana",{Ingredient("goldnugget",1),Ingredient("nightmarefuel",1)},TECH.NONE,{builder_tag="kana_build",product ="thulecite_pieces",numtogive = 1},{"CHARACTER"})--不影响原版且不和其他同类型冲突 

--- 伏特羊角 可以被 牛角转换---制作旋风法杖基础材料 麋鹿鹅羽毛 goose_feather 10 福特羊犄角 lightninggoathorn 1 齿轮 gears 1 
AddRecipe2("lightninggoathorn_kana",{Ingredient("horn",10)},TECH.NONE,{builder_tag="kana_build",product ="lightninggoathorn",numtogive = 1},{"CHARACTER"})--不影响原版且不和其他同类型冲突
---特殊物品 勤俭王冠
AddRecipe("headwear2",{GLOBAL.Ingredient("greenstaff",1),GLOBAL.Ingredient("greenamulet",1),GLOBAL.Ingredient("ruinshat",1)},RECIPETABS.MAGIC,TECH.MAGIC_TWO,nil,nil,nil,nil,"kana_build","images/inventoryimages/headwear2.xml","headwear2.tex" )
---特殊物品 kana发卡
AddRecipe("headwear",{Ingredient(CHARACTER_INGREDIENT.SANITY,150)},RECIPETABS.MAGIC,TECH.MAGIC_TWO,nil,nil,nil,nil,"kana_build","images/inventoryimages/headwear.xml","headwear.tex" )
---陨石雨
AddRecipe("achivbook_meteor_kana",{GLOBAL.Ingredient("papyrus",2),GLOBAL.Ingredient("moonrocknugget",3),GLOBAL.Ingredient("yellowgem",1)},GLOBAL.CUSTOM_RECIPETABS.BOOKS,TECH.NONE,nil,nil,nil,nil,"kana_build","images/inventoryimages/achivbook_meteor_kana.xml","achivbook_meteor_kana.tex" ,nil,"achivbook_meteor_kana")
---石化林
AddRecipe("achivbook_shakespeare_kana",{GLOBAL.Ingredient("papyrus",2),GLOBAL.Ingredient("purplegem",1),GLOBAL.Ingredient("orangegem",1)},GLOBAL.CUSTOM_RECIPETABS.BOOKS,TECH.NONE,nil,nil,nil,nil,"kana_build","images/inventoryimages/achivbook_shakespeare_kana.xml","achivbook_shakespeare_kana.tex" ,nil,"achivbook_shakespeare_kana")
--炽热太阳鱼
AddRecipe2("oceanfish_small_8_kana",{Ingredient("redgem",10) },TECH.NONE,{builder_tag="kana_build",product ="oceanfish_small_8",numtogive = 1},{"CHARACTER"})
--冰鲷鱼
--AddRecipe2("kana_oceanfish_medium_8_inv",{Ingredient("pondfish",2),Ingredient("bluegem",1),Ingredient("ice",5)},TECH.NONE,{builder_tag="kana_build",product="oceanfish_medium_8_inv",description="kana".."oceanfish_medium_8_inv"},{"CHARACTER"})
--珍珠
AddRecipe2("kana_hermit_pearl",{Ingredient("opalpreciousgem",1)},TECH.NONE,{builder_tag="kana_build",product="hermit_pearl",description="kana".."hermit_pearl"},{"CHARACTER"})
--月黑书
--AddRecipe2("kana_book_moon_black", {Ingredient("papyrus",2),Ingredient("opalpreciousgem",1),Ingredient("butterflywings",2)},TECH.BOOKCRAFT_ONE,{builder_tag="kana",image="book_moon.tex"},{"CHARACTER"})
--AddRecipe2("kana_book_moon_black2",{Ingredient("papyrus",2),Ingredient("opalpreciousgem",1),Ingredient("butterflywings",2)},TECH.BOOKCRAFT_ONE,{builder_tag="bookbuilder",product="kana_book_moon_black",image="book_moon.tex"},{"CHARACTER"})

---部分使用魔法书
---book_birds 世界鸟类大全
AddRecipe2("book_birds_kana",{Ingredient("papyrus",2),Ingredient("bird_egg",2) },TECH.NONE,{builder_tag="kana_build",product ="book_birds",numtogive = 1},{"CHARACTER"})
---垂钓者生存指南 book_fish
AddRecipe2("book_fish_kana",{Ingredient("papyrus",2),Ingredient("oceanfishingbobber_ball",2)},TECH.NONE,{builder_tag="kana_build",product ="book_fish",numtogive = 1},{"CHARACTER"})
---月之魔典 book_moon
AddRecipe2("book_moon_kana",{Ingredient("papyrus",2),Ingredient("opalpreciousgem",2)},TECH.NONE,{builder_tag="kana_build",product ="book_moon",numtogive = 1},{"CHARACTER"})
---实用求雨仪式 book_rain
AddRecipe2("book_rain_kana",{Ingredient("papyrus",2),Ingredient("goose_feather",2)},TECH.NONE,{builder_tag="kana_build",product ="book_rain",numtogive = 1},{"CHARACTER"})
---养蜂笔记 book_bees
AddRecipe2("book_bees_kana",{Ingredient("papyrus",2),Ingredient("honey",4),Ingredient("stinger",8)},TECH.NONE,{builder_tag="kana_build",product ="book_bees",numtogive = 1},{"CHARACTER"})
---万物百科 book_research_station
--书架
AddRecipe2("bookstation_kana",{Ingredient("papyrus",4),Ingredient("livinglog",2)},TECH.NONE,{builder_tag="kana_build",product ="bookstation",numtogive=1},{"CHARACTER"})
--园艺学简编版
AddRecipe2("book_horticulture_kana",{Ingredient("papyrus",2),Ingredient("seeds",5),Ingredient("spoiled_food",5)},TECH.NONE,{builder_tag="kana_build",product ="book_horticulture",numtogive = 1},{"CHARACTER"})
--园艺学扩展版
AddRecipe2("book_horticulture_upgraded_kana",{Ingredient("papyrus",2),Ingredient("featherpencil",1),Ingredient("book_horticulture",1)},TECH.NONE,{builder_tag="kana_build",product ="book_horticulture_upgraded",numtogive = 1},{"CHARACTER"})
--应用造林学
AddRecipe2("book_silviculture_kana",{Ingredient("papyrus",2),Ingredient("livinglog",2)},TECH.NONE,{builder_tag="kana_build",product ="book_silviculture",numtogive = 1},{"CHARACTER"})
--睡前故事
AddRecipe2("book_sleep_kana",{Ingredient("papyrus",2),Ingredient("nightmarefuel",2)},TECH.NONE,{builder_tag="kana_build",product ="book_sleep",numtogive = 1},{"CHARACTER"})
--末日将至！
AddRecipe2("book_brimstone_kana",{Ingredient("papyrus",2),Ingredient("redgem",1)},TECH.NONE,{builder_tag="kana_build",product ="book_brimstone",numtogive = 1},{"CHARACTER"})
--触手的召唤
AddRecipe2("book_tentacles_kana",{Ingredient("papyrus",2),Ingredient("tentaclespots",1)},TECH.NONE,{builder_tag="kana_build",product ="book_tentacles",numtogive = 1},{"CHARACTER"})
---意念控火术详解
AddRecipe2("book_fire_kana",{Ingredient("papyrus",2),Ingredient("book_brimstone",1)},TECH.NONE,{builder_tag="kana_build",product ="book_fire",numtogive = 1},{"CHARACTER"})
---克服蛛形纲恐惧症
AddRecipe2("book_web_kana",{Ingredient("papyrus",2),Ingredient("silk",8)},TECH.NONE,{builder_tag="kana_build",product ="book_web",numtogive = 1},{"CHARACTER"})
---控温学
AddRecipe2("book_temperature_kana",{Ingredient("papyrus",2),Ingredient("heatrock",1)},TECH.NONE,{builder_tag="kana_build",product ="book_temperature",numtogive = 1},{"CHARACTER"})
---永恒之光
AddRecipe2("book_light_kana",{Ingredient("papyrus",2),Ingredient("lightbulb",1)},TECH.NONE,{builder_tag="kana_build",product ="book_light",numtogive = 1},{"CHARACTER"})
--永恒之光之复兴
AddRecipe2("book_light_upgraded_kana",{Ingredient("papyrus",2),Ingredient("book_light",1)},TECH.NONE,{builder_tag="kana_build",product ="book_light_upgraded",numtogive = 1},{"CHARACTER"})

---类似植物人 可以制作的植物
AddRecipe2("spoiled_food_kana",{Ingredient("foliage",1)},TECH.NONE,{product="spoiled_food",numtogive=1,builder_tag="kana_build"},{"CHARACTER"})--制造腐败
--火龙果
AddRecipe2("dragonfruit_kana",{Ingredient(CHARACTER_INGREDIENT.HEALTH,50)},TECH.NONE,{builder_tag="kana_build",product ="dragonfruit",numtogive = 1},{"CHARACTER"})--
--南瓜
AddRecipe2("pumpkin_kana",{Ingredient(CHARACTER_INGREDIENT.HEALTH,50)},TECH.NONE,{builder_tag="kana_build",product ="pumpkin",numtogive = 1},{"CHARACTER"})--
--曼德拉
AddRecipe2("mandrake_active_kana",{Ingredient(CHARACTER_INGREDIENT.HEALTH,200)},TECH.NONE,{builder_tag="kana_build",product ="mandrake_active",numtogive = 1},{"CHARACTER"})--
--potato土豆
AddRecipe2("potato_kana",{Ingredient(CHARACTER_INGREDIENT.HEALTH,30)},TECH.NONE,{builder_tag="kana_build",product ="potato",numtogive = 1},{"CHARACTER"})--
--树苗
AddRecipe2("sapling_kana",{Ingredient("twigs",1),Ingredient(CHARACTER_INGREDIENT.HEALTH,10)},TECH.NONE,{product="sapling",numtogive=1,builder_tag="kana_build"},{"CHARACTER"})
--泻根糖浆
AddRecipe2("ipecacsyrup_kana",{Ingredient("red_cap",1),Ingredient("spoiled_food",2),Ingredient(CHARACTER_INGREDIENT.HEALTH,20)},TECH.NONE,{product="ipecacsyrup",numtogive=1,builder_tag="kana_build"},{"CHARACTER"})
--- 活木合成转换
AddRecipe2("livinglog_kana",{Ingredient("nightmarefuel",4),Ingredient("log",4)},TECH.NONE,{builder_tag="kana_build",product ="livinglog",numtogive = 1},{"CHARACTER"})


---类似植物人 可以制作的植物
---自动修理机Auto-Mat-O-Chanic 废铁+电子元件
AddRecipe2("wagpunkbits_kit_kana",{ Ingredient("transistor",2)},TECH.NONE,{product="wagpunkbits_kit",numtogive=1,builder_tag="kana_build"},{"CHARACTER"})

---逆威尔逊 暗影材料
AddRecipe2("horrorfuel_kana",{Ingredient("nightmarefuel",4)},TECH.NONE,{product="horrorfuel",numtogive=1,builder_tag="kana_build"},{"CHARACTER"})---制造存粹恐惧
AddRecipe2("dreadstone_kana",{Ingredient("horrorfuel",4)},TECH.NONE,{product="dreadstone",numtogive=1,builder_tag="kana_build"},{"CHARACTER"})---制造绝望石
AddRecipe2("voidcloth_kana",{Ingredient("nightmarefuel",4),Ingredient("horrorfuel",4),Ingredient("dreadstone",4)},TECH.NONE,{product="voidcloth",numtogive=1,builder_tag="kana_build"},{"CHARACTER"})

---月亮材料 注能月亮碎片 moonglass_charged
AddRecipe2("moonglass_charged_kana",{Ingredient("moonglass",2),Ingredient("moonrocknugget",2)},TECH.NONE,{product="moonglass_charged",numtogive=1,builder_tag="kana_build"},{"CHARACTER"})
AddRecipe2("purebrilliance_kana",{Ingredient("moonglass_charged",2)},TECH.NONE,{product="purebrilliance",numtogive=1,builder_tag="kana_build"},{"CHARACTER"})
AddRecipe2("lunarplant_husk_kana",{Ingredient("moonglass",2),Ingredient("purebrilliance",2)},TECH.NONE,{product="lunarplant_husk",numtogive=1,builder_tag="kana_build"},{"CHARACTER"})
AddRecipe2("rottenegg_kana",{ Ingredient("bird_egg",2)  },TECH.NONE,{product="rottenegg",numtogive=1,builder_tag="kana_build"},{"CHARACTER"})---臭鸡蛋
---archive_cookpot 远古窑
--AddRecipe2("archive_cookpot_kana",{ Ingredient("moonrocknugget",3),Ingredient("thulecite_pieces",3),Ingredient("twigs",6)  },TECH.NONE,{product="archive_cookpot",numtogive=1,builder_tag="kana_build"},{"CHARACTER"})

---木炭
AddRecipe2("charcoal_kana",{ Ingredient("log",2)},TECH.NONE,{product="charcoal",numtogive=1,builder_tag="kana_build"},{"CHARACTER"})
--spicepack  厨师袋
AddRecipe2("spicepack_kana",{ Ingredient("cutgrass",4),Ingredient("twigs",4),Ingredient("nitre",2)},TECH.NONE,{product="spicepack",numtogive=1,builder_tag="kana_build"},{"CHARACTER"})
---saltrock 盐  用10灰烬 制造1盐 
AddRecipe2("saltrock_kana",{ Ingredient("ash",10)},TECH.NONE,{product="saltrock",numtogive=1,builder_tag="kana_build"},{"CHARACTER"})
---saltrock 盐  用1硝石+魔法暗影燃料 实际上是 硝酸盐 制造1盐 
AddRecipe2("saltrock_kana",{Ingredient("nightmarefuel",1),Ingredient("nitre",1)},TECH.NONE,{product="saltrock",numtogive=1,builder_tag="kana_build"},{"CHARACTER"})
---saltrock 硝石  用1硝石+魔法暗影燃料 实际上是 硝酸盐 制造1盐 
AddRecipe2("nitre_kana2",{Ingredient("nightmarefuel",1),Ingredient("saltrock",1)},TECH.NONE,{product="nitre",numtogive=1,builder_tag="kana_build"},{"CHARACTER"})

--铥矿制作配方：原因是某些模组覆盖了原版的铥矿配方导致不能用铥矿碎片合成 所以我加一个 配方一样 
AddRecipe2("thulecite_kana",{Ingredient("thulecite_pieces",6)},TECH.NONE,{builder_tag="kana_build",product ="thulecite",numtogive = 1},{"CHARACTER"})
--超越威尔逊的转换  --- 树枝
AddRecipe2("twigs_kana",{Ingredient("log",1)},TECH.NONE,{builder_tag="kana_build",product ="twigs",numtogive = 3},{"CHARACTER"})
--超越威尔逊的转换  --- 2小肉变大肉
AddRecipe2("meat_kana",{Ingredient("smallmeat",2)},TECH.NONE,{builder_tag="kana_build",product ="meat",numtogive = 1},{"CHARACTER"})
--超越威尔逊的转换  --- 1大肉变2小肉
AddRecipe2("smallmeat_kana",{Ingredient("meat",1)},TECH.NONE,{builder_tag="kana_build",product ="smallmeat",numtogive = 2},{"CHARACTER"})
AddRecipe2("beardhair_kana",{Ingredient("beefalowool",1)},TECH.NONE,{builder_tag="kana_build",product ="beardhair",numtogive = 2},{"CHARACTER"})
AddRecipe2("moonrocknugget_kana",{Ingredient("marble",2)},TECH.NONE,{builder_tag="kana_build",product ="moonrocknugget",numtogive = 1},{"CHARACTER"})
AddRecipe2("nitre_kana",{Ingredient("rocks",4)},TECH.NONE,{builder_tag="kana_build",product ="nitre",numtogive = 1},{"CHARACTER"})
AddRecipe2("flint_kana",{Ingredient("rocks",3)},TECH.NONE,{builder_tag="kana_build",product ="flint",numtogive = 1},{"CHARACTER"})
AddRecipe2("rocks_kana",{Ingredient("flint",1)},TECH.NONE,{builder_tag="kana_build",product ="rocks",numtogive = 3},{"CHARACTER"})
AddRecipe2("cutgrass_kana",{Ingredient("log",1)},TECH.NONE,{builder_tag="kana_build",product ="cutgrass",numtogive = 3},{"CHARACTER"})
---稀有物品

---坎普斯背包 krampus_sack
AddRecipe2("krampus_sack_kana",{Ingredient("opalpreciousgem",2),Ingredient("shadowheart",1)},TECH.NONE,{builder_tag="kana_build",product ="krampus_sack",numtogive = 1},{"CHARACTER"})
---暗影心脏
AddRecipe2("shadowheart_kana",{Ingredient("opalpreciousgem",1)},TECH.NONE,{builder_tag="kana_build",product ="shadowheart",numtogive = 1},{"CHARACTER"})
AddRecipe2("shadowheart_infused_kana",{Ingredient("shadowheart",1),Ingredient("opalpreciousgem",1)},TECH.NONE,{builder_tag="kana_build",product ="shadowheart_infused",numtogive = 1},{"CHARACTER"})
AddRecipe2("shadowheart2_kana",{Ingredient("shadowheart_infused",1)},TECH.NONE,{builder_tag="kana_build",product ="shadowheart",numtogive = 1},{"CHARACTER"})
--火花柜
AddRecipe2("security_pulse_cage_kana",{Ingredient("thulecite",1),Ingredient("moonglass",1)},TECH.NONE,{builder_tag="kana_build",product ="security_pulse_cage",numtogive = 1},{"CHARACTER"})
--ancientfruit_nightvision 夜莓 Nightberry  用 发光浆果 wormlight_lesser + 以太余烬 转换
AddRecipe2("ancientfruit_nightvision_kana",{Ingredient("wormlight_lesser",1),Ingredient("willow_ember",1)},TECH.NONE,{builder_tag="kana_build",product ="ancientfruit_nightvision",numtogive = 1},{"CHARACTER"})
AddRecipe2("wormlight_lesser_kana",{Ingredient("nightmarefuel",1)},TECH.NONE,{builder_tag="kana_build",product ="wormlight_lesser",numtogive = 1},{"CHARACTER"})
---glowberrymousse 发光浆果慕斯 Glow Berry Mousse
AddRecipe2("ancientfruit_nightvision_kana2",{Ingredient("glowberrymousse",1)},TECH.NONE,{builder_tag="kana_build",product ="ancientfruit_nightvision",numtogive = 5},{"CHARACTER"})
AddRecipe2("mosquitosack_kana",{Ingredient(CHARACTER_INGREDIENT.HEALTH,10)},TECH.NONE,{builder_tag="kana_build",product ="mosquitosack",numtogive = 1},{"CHARACTER"})--mosquitosack 蚊子血囊
AddRecipe2("walking_stick_kana",{Ingredient("log",4),Ingredient("charcoal",1),Ingredient("nightmarefuel",1)},TECH.NONE,{builder_tag="kana_build",product ="walking_stick",numtogive = 1},{"CHARACTER"})--walking_stick 木手杖
----------女武神 头盔和长矛 制作代码  这段代码会是限制材料和成品的性能

---------阿比盖尔能力 温蒂能力
--哀悼荣耀---Mourning Glory
AddRecipe2("ghostflower_kana",{Ingredient("purebrilliance",2),Ingredient("horrorfuel",2)},TECH.NONE,{builder_tag="kana_build",product ="ghostflower",numtogive = 1},{"CHARACTER"})
----蒸馏复仇Distilled Vengeance
AddRecipe2("ghostlyelixir_retaliation_kana",{Ingredient("livinglog",2),Ingredient("ghostflower",6)},TECH.NONE,{builder_tag="kana_build",product ="ghostlyelixir_retaliation",numtogive = 1},{"CHARACTER"})
--夜影万金油Nightshade Nostrum
AddRecipe2("ghostlyelixir_attack_kana",{Ingredient("stinger",2),Ingredient("ghostflower",6)},TECH.NONE,{builder_tag="kana_build",product ="ghostlyelixir_attack",numtogive = 1},{"CHARACTER"})
--强健精油 Vigor Mortis
AddRecipe2("ghostlyelixir_speed_kana",{Ingredient("honey",2),Ingredient("ghostflower",2)},TECH.NONE,{builder_tag="kana_build",product ="ghostlyelixir_speed",numtogive = 1},{"CHARACTER"})
--幽魂花冠 Wraith's Wreath
AddRecipe2("ghostflowerhat_kana",{Ingredient("ghostflower",6)},TECH.NONE,{builder_tag="kana_build",product ="ghostflowerhat",numtogive = 1},{"CHARACTER"})

---召唤boss  钢铁巨人  确定可以通过这种方式直接制造钢铁巨人   钢铁巨人独立mod 3167114447
---AddRecipe2("ancient_hulk_kana",{Ingredient("gears",20)},TECH.NONE,{builder_tag="kana_build",product ="ancient_hulk",numtogive = 1},{"CHARACTER"}) 严重问题会导致其他玩家看不到血条
---发条机器人 损坏的发条装置 Broken Clockworks

---AddRecipe2("chessjunk2_kana",{Ingredient("gears",2),Ingredient("wagpunk_bits",2)},TECH.NONE,{builder_tag="kana_build",product ="chessjunk2",numtogive = 1},{"CHARACTER"})--损坏的发条装置 Broken Clockworks
---AddRecipe2("chessjunk3_kana",{Ingredient("gears",2),Ingredient("wagpunk_bits",2)},TECH.NONE,{builder_tag="kana_build",product ="chessjunk3",numtogive = 1},{"CHARACTER"})--损坏的发条装置 Broken Clockworks

--AddRecipe2("rook_kana",{Ingredient("gears",2)},TECH.NONE,{builder_tag="kana_build",product ="rook",numtogive = 1},{"CHARACTER"})--发条战车 Clockwork Rook
--AddRecipe2("bishop_kana",{Ingredient("gears",2),Ingredient("purplegem",1)},TECH.NONE,{builder_tag="kana_build",product ="bishop",numtogive = 1},{"CHARACTER"})--发条主教 Clockwork Bishop
--AddRecipe2("knight_kana",{Ingredient("gears",2)},TECH.NONE,{builder_tag="kana_build",product ="knight",numtogive = 1},{"CHARACTER"})--发条骑士 Clockwork Knight

--AddRecipe2("rook_nightmare_kana",{Ingredient("gears",1),Ingredient("nightmarefuel",2),Ingredient("thulecite_pieces",2)},TECH.NONE,{builder_tag="kana_build",product ="rook_nightmare",numtogive = 1},{"CHARACTER"})--损坏发条战车 Clockwork Rook
--AddRecipe2("bishop_nightmare_kana",{Ingredient("gears",1),Ingredient("purplegem",1),Ingredient("thulecite_pieces",1),Ingredient("nightmarefuel",1)},TECH.NONE,{builder_tag="kana_build",product ="bishop_nightmare",numtogive = 1},{"CHARACTER"})--损坏发条主教 Clockwork Bishop
--AddRecipe2("knight_kana",{Ingredient("gears",1),Ingredient("nightmarefuel",1),Ingredient("thulecite_pieces",1)},TECH.NONE,{builder_tag="kana_build",product ="knight",numtogive = 1},{"CHARACTER"})--损坏发条骑士 Clockwork Knight






----跳劈代码
-- 先定义按键常量（比如绑定R键，值为KEY_R，需确保TUNING可访问）
if TUNING.kana_Super_Atk == nil then
    TUNING.kana_Super_Atk = GLOBAL.KEY_R -- 绑定R键触发跳劈
end

---- 1. 击中目标特效逻辑（修正事件名+Tag判断）
local function OnHitOther_kana(inst, data)
    -- 仅kana角色且开启跳劈时触发特效
    if inst.prefab == "kana" and inst:HasTag("kana_superatk") and data.target and data.target:IsValid() then
        local fx = GLOBAL.SpawnPrefab("wanda_attack_pocketwatch_old_fx")
        if fx then -- 空值校验
            local x, y, z = data.target.Transform:GetWorldPosition()
            local radius = data.target:GetPhysicsRadius(.5)
            local angle = (inst.Transform:GetRotation() - 90) * GLOBAL.DEGREES
            fx.Transform:SetPosition(x + math.sin(angle) * radius, 0, z + math.cos(angle) * radius)
        end
    end
end

---- 2. 跳劈倍率+攻击范围核心逻辑
AddPlayerPostInit(function(inst)
    if not GLOBAL.TheWorld.ismastersim then
        return
    end

    -- 监听正确的击中事件（饥荒标准事件名：onhitother）
    inst:ListenForEvent("onhitother", OnHitOther_kana)

    -- 重写GetAttacked（受击伤害倍率，可选逻辑）
    local _getAttacked = inst.components.combat.GetAttacked
    inst.components.combat.GetAttacked = function(self, attacker, damage, weapon, stimuli, spdamage, ...)
        if inst.prefab == "kana" and inst:HasTag("kana_superatk") and damage then
            damage = damage * 1.5 -- 跳劈时受击伤害倍率（若需攻击倍率则看CalcDamage）
        end
        return _getAttacked(self, attacker, damage, weapon, stimuli, spdamage, ...)
    end

    -- 重写CalcDamage（攻击伤害倍率，跳劈核心倍率）
    local _calcDamage = inst.components.combat.CalcDamage
    inst.components.combat.CalcDamage = function(self, target, weapon, multiplier)
        local damage, spdamage = _calcDamage(self, target, weapon, multiplier)
        if inst.prefab == "kana" and inst:HasTag("kana_superatk") and damage then
            damage = damage * 1.5 -- 跳劈攻击倍率
        end
        return damage, spdamage
    end
end)

---- 3. 跳劈开关函数（修正逻辑边界+空值校验）
local function Super_Atk(inst)
    -- 仅kana角色可操作
    if inst.prefab ~= "kana" then
        return
    end

    -- 关闭跳劈（移除Tag+还原参数）
    if inst:HasTag("kana_superatk") then
        inst:RemoveTag("kana_superatk")
        inst.components.combat.attackrange = 5 -- 还原攻击距离
        if inst.components.talker then
            inst.components.talker:Say("跳劈！关！")
        end
        -- 移除特效
        if inst.super_fx and inst.super_fx:IsValid() then
            inst.super_fx:Remove()
            inst.super_fx = nil
        end
    -- 开启跳劈（添加Tag+设置参数）
    else
        inst:AddTag("kana_superatk")
        inst.components.combat.attackrange = 20 -- 扩大攻击距离
        if inst.components.talker then
            inst.components.talker:Say("跳劈！开！")
        end
        -- 移除旧特效
        if inst.super_fx and inst.super_fx:IsValid() then
            inst.super_fx:Remove()
            inst.super_fx = nil
        end
        -- 创建新特效（空值校验）
        inst.super_fx = GLOBAL.SpawnPrefab("super_atk_fx")
        if inst.super_fx then
            inst.super_fx.entity:SetParent(inst.entity)
            inst.super_fx.Transform:SetPosition(0, 0.2, 0)
        end
    end
end

---- 4. 注册RPC（服务端触发）
AddModRPCHandler("Super_Atk", "Super_Atk", Super_Atk)

---- 5. R键触发逻辑（客户端）
GLOBAL.TheInput:AddKeyDownHandler(TUNING.kana_Super_Atk, function()
    local player = GLOBAL.ThePlayer
    local screen = GLOBAL.TheFrontEnd:GetActiveScreen()
    local IsHUDActive = screen and screen.name == "HUD"
    -- 仅kana角色、非鬼魂、HUD激活时触发
    if player and not player:HasTag("playerghost") and player.prefab == "kana" and IsHUDActive then
        GLOBAL.SendModRPCToServer(GLOBAL.MOD_RPC["Super_Atk"]["Super_Atk"])
    end
end)

---- 6. 特殊法杖列表（用于排除远程武器）
local special_staff = {
    "staff_lunarplant",
    "icestaff",
    "firestaff"
}

---- 7. 服务端状态机（修正Tag判断为kana_superatk）
local function NewAtk_kana(sg)
    local old_handler = sg.actionhandlers[GLOBAL.ACTIONS.ATTACK].deststate
    sg.actionhandlers[GLOBAL.ACTIONS.ATTACK].deststate = function(inst, action)
        local weapon = inst.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS) or nil
        -- 核心：判断kana_superatk Tag，而非kana
        if weapon and not (
            weapon:HasTag("blowdart") or 
            weapon:HasTag("thrown") or 
            (weapon:HasTag("rangedweapon") and not GLOBAL.table.contains(special_staff, weapon.prefab))
        ) and inst:HasTag("kana_superatk") and -- 改为kana_superatk
            not inst.sg:HasStateTag("attack") and 
            (inst.components.rider ~= nil and not inst.components.rider:IsRiding()) then
            return "kanaleap"
        else
            return old_handler(inst, action)
        end
    end
end

---- 8. 客户端状态机（保持Tag一致，优化判断）
local function NewAtk_Client_kana(sg)
    local old_handler = sg.actionhandlers[GLOBAL.ACTIONS.ATTACK].deststate
    sg.actionhandlers[GLOBAL.ACTIONS.ATTACK].deststate = function(inst, action)
        local weapon = inst.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS) or nil
        -- 统一判断kana_superatk Tag
        if weapon and not (weapon:HasTag("blowdart") or weapon:HasTag("thrown")) and 
            inst:HasTag("kana_superatk") and 
            not inst.sg:HasStateTag("attack") then
            -- 简化骑乘判断
            local is_riding = (inst.components.rider and inst.components.rider:IsRiding()) or 
                              (inst.replica.rider and inst.replica.rider:IsRiding())
            if not is_riding then
                return "kanaleap_pre"
            end
        end
        return old_handler(inst, action)
    end
end

---- 9. 注册状态机
AddStategraphPostInit("wilson", NewAtk_kana)
AddStategraphPostInit("wilson_client", NewAtk_Client_kana)

---- 10. 跳劈特效辅助函数
local function Effect(inst)
    if GLOBAL.TheWorld.state.wetness > 25 then
        local puff = GLOBAL.SpawnPrefab("weregoose_splash_med2")
        if puff then
            puff.Transform:SetPosition(inst.Transform:GetWorldPosition())
        end
    end
end

---- 11. 添加服务端跳劈状态
AddStategraphState('wilson', GLOBAL.State{
    name = "kanaleap",
    tags = { "attack", "backstab", "busy", "notalking", "abouttoattack", "pausepredict", "nointerrupt" },

    onenter = function(inst, data)
        Effect(inst)
        local buffaction = inst:GetBufferedAction()
        local target = buffaction ~= nil and buffaction.target or nil
        inst.components.combat:SetTarget(target)
        inst.components.combat:StartAttack()
        inst.AnimState:PlayAnimation("atk_leap", false)
        inst.Transform:SetEightFaced()
        inst.AnimState:ClearOverrideBuild("player_lunge")
        inst.AnimState:ClearOverrideBuild("player_attack_leap")
        inst.components.locomotor:Stop()
        inst.components.locomotor:EnableGroundSpeedMultiplier(false)
        if inst.components.playercontroller ~= nil then
            inst.components.playercontroller:RemotePausePrediction()
        end
    end,

    onexit = function(inst)
        inst.components.combat:SetTarget(nil)
        if inst.sg:HasStateTag("abouttoattack") then
            inst.components.combat:CancelAttack()
        end
        inst.Transform:SetFourFaced()
        inst.components.locomotor:Stop()
        inst.Physics:ClearMotorVelOverride()
        inst:DoTaskInTime(0, function(inst)
            if inst.components.playercontroller then
                inst.components.playercontroller:Enable(true)
            end
        end)
        inst.components.locomotor:EnableGroundSpeedMultiplier(true)
        inst.AnimState:AddOverrideBuild("player_lunge")
        inst.AnimState:AddOverrideBuild("player_attack_leap")
    end,

    timeline = {
        GLOBAL.TimeEvent(0 * GLOBAL.FRAMES, function(inst)
            inst.Physics:ClearCollisionMask()
            inst.Physics:CollidesWith(GLOBAL.COLLISION.WORLD)
            local buffaction = inst:GetBufferedAction()
            local target = buffaction ~= nil and buffaction.target or nil
            if target ~= nil then
                inst.sg.statemem.startingpos = inst:GetPosition()
                inst.sg.statemem.targetpos = target:GetPosition()
                if inst.sg.statemem.startingpos.x ~= inst.sg.statemem.targetpos.x or
                    inst.sg.statemem.startingpos.z ~= inst.sg.statemem.targetpos.z then
                    inst.leapvelocity = math.sqrt(GLOBAL.distsq(
                        inst.sg.statemem.startingpos.x, inst.sg.statemem.startingpos.z,
                        inst.sg.statemem.targetpos.x, inst.sg.statemem.targetpos.z
                    )) / (12 * GLOBAL.FRAMES)
                end
            end
            inst.SoundEmitter:PlaySound("turnoftides/common/together/boat/jump")
        end),

        GLOBAL.TimeEvent(12 * GLOBAL.FRAMES, function(inst)
            inst.sg:RemoveStateTag("abouttoattack")
            inst.components.locomotor:Stop()
            inst.Physics:ClearMotorVelOverride()
            inst:PerformBufferedAction()
            inst.components.playercontroller:Enable(false)
            inst.components.locomotor:EnableGroundSpeedMultiplier(true)
            inst.sg:RemoveStateTag("busy")
            inst.Physics:CollidesWith(GLOBAL.COLLISION.OBSTACLES)
            inst.Physics:CollidesWith(GLOBAL.COLLISION.SMALLOBSTACLES)
        end),

        GLOBAL.TimeEvent(14 * GLOBAL.FRAMES, function(inst)
            inst.leapvelocity = 10
            local puff = GLOBAL.SpawnPrefab("dirt_puff")
            if puff then
                puff.Transform:SetPosition(inst.Transform:GetWorldPosition())
            end
        end),

        GLOBAL.TimeEvent(19 * GLOBAL.FRAMES, function(inst)
            local puff = GLOBAL.SpawnPrefab("dirt_puff")
            if puff then
                puff.Transform:SetPosition(inst.Transform:GetWorldPosition())
            end
        end),

        GLOBAL.TimeEvent(24 * GLOBAL.FRAMES, function(inst)
            local puff = GLOBAL.SpawnPrefab("dirt_puff")
            if puff then
                puff.Transform:SetPosition(inst.Transform:GetWorldPosition())
            end
            inst.sg:RemoveStateTag("busy")
            inst.sg:RemoveStateTag("attack")
            inst.sg:RemoveStateTag("nointerrupt")
            inst.sg:RemoveStateTag("pausepredict")
            inst.sg:AddStateTag("idle")
            inst.leapvelocity = 0
            inst.Physics:Stop()
            inst.Physics:CollidesWith(GLOBAL.COLLISION.CHARACTERS)
            inst.components.playercontroller:Enable(true)
        end),
    },

    onupdate = function(inst)
        if inst.leapvelocity then
            inst.Physics:SetMotorVel(inst.leapvelocity, 0, 0)
        end
    end,

    events = {
        GLOBAL.EventHandler("animover", function(inst)
            inst.sg:GoToState("idle")
        end),
    },
})

---- 12. 添加客户端跳劈预状态
AddStategraphState('wilson_client', GLOBAL.State{
    name = "kanaleap_pre",
    tags = { "busy" },

    onenter = function(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("atk_leap_pre", false)
        inst.AnimState:PushAnimation("atk_leap_lag", false)

        local buffaction = inst:GetBufferedAction()
        if buffaction ~= nil then
            inst:PerformPreviewBufferedAction()
            if buffaction.pos ~= nil then
                inst:ForceFacePoint(buffaction:GetActionPoint():Get())
            end
        end

        inst.sg:SetTimeout(2)
    end,

    onupdate = function(inst)
        if inst:HasTag("busy") then
            if inst.entity:FlattenMovementPrediction() then
                inst.AnimState:PlayAnimation("atk_leap_lag", false)
            end
        elseif inst.bufferedaction == nil then
            inst.sg:GoToState("idle")
        end
    end,

    ontimeout = function(inst)
        inst:ClearBufferedAction()
        inst.sg:GoToState("idle")
    end,
})

----跳劈代码





--代码是引用 全能力 作者  绯世行 的 所有能力 3366313760 --代码是引用 全能力 作者  绯世行 的 所有能力 3366313760 

local Constructor = require("aab_utils/constructor")
Constructor.SetEnv(env)
----------------------------------------------------------------------------------------------------
---载入了这个目录的lua文件导致无法读取存档
--local Constructor = require("aab_utils/constructor")---这个导致无法读取存档 在测试读取的是scripts\aab_utils\constructor.lua 里面的内容---载入了这个目录的lua文件导致无法读取存档
--Constructor.SetEnv(env)


local language
if GetModConfigData("language") ~= "AUTO" then
    language = GetModConfigData("language")---这个是获取了 maininfo里面的代码的configuration_options 参数
else
    local lan = require "languages/loc".GetLanguage()
    language = (lan == LANGUAGE.CHINESE_S or lan == LANGUAGE.CHINESE_S_RAIL) and "zh" or "en"
end

function AAB_L(en,zh)
    return language == "en" and en or zh
end

GLOBAL.AAB_L = AAB_L

local function Trace(character,root,tab,path)
    for k,v in pairs(tab) do
        if type(v) == "table" then
            table.insert(path,k)
            Trace(character,root,v,path)
            table.remove(path,#path)
        else
            for k2,v2 in pairs(root) do
                if k2 ~= path[1] then
                    local data = v2
                    for i = 2,#path do
                        data = data[path[i]]
                        if not data then break end
                    end
                    if type(data) == "table" then
                        -- if data[k] == "only_used_by_" .. string.lower(character) then
                        if type(data[k]) == "string" and string.match(data[k],"only_used_by_" .. string.lower(character)) then
                            data[k] = v
                        end
                    end
                end
            end
        end
    end
end

local function DFS(character,tab)
    for k,v in pairs(tab) do
        if type(v) == "table" then
            if v[character] and type(v[character]) == "table" then
                --新的递归
                Trace(character,v,v[character],{ character })
            else
                DFS(character,v)
            end
        end
    end
end

function AAB_ReplaceCharacterLines(character)
    DFS(string.upper(character),STRINGS)
end

----------------------------------------------------------------------------------------------------

local FX_DATA = {
    -- {
    -- 	name = "mami_gun_flash_fx",
    -- 	anim = "anim",
    -- 	fn = function(inst,proxy) end,
    -- 	eightfaced = true,
    -- 	sound = "mami_sfx/gun/oneshot",
    -- 	soundvolumn = 0.15,
    -- },
}
function AAB_AddFx(data)
    table.insert(FX_DATA,data)
end

----------------------------------------------------------------------------------------------------

--- 统一添加
local AAB_COMPONENT_ACTIONS = {
    SCENE = {},
    USEITEM = {},
    POINT = {},
    EQUIPPED = {},
    INVENTORY = {}
}

function AAB_AddComponentAction(actiontype,component,fn)
    AAB_COMPONENT_ACTIONS[actiontype][component] = AAB_COMPONENT_ACTIONS[actiontype][component] or {}
    table.insert(AAB_COMPONENT_ACTIONS[actiontype][component],fn)
end

----------------------------------------------------------------------------------------------------
Ig = Ingredient

function AAB_AddCharacterRecipe(name,ingredients,data,filters)
    data = data or {}
    return AddRecipe2(name,
        ingredients,
        TECH.NONE,
        data,
        filters or { "CHARACTER" }
    )
end

----------------------------------------------------------------------------------------------------
local Utils = require("aab_utils/utils")

--这个函数是开启某个角色后会载入对应角色名称的技能树 -- 目前已经被我限制成为只能某个指定人物名称 kana 才能开启
function AAB_ActivateSkills(character)   
    local SKILLTREE_DEFS
    local function IsActivatedBefore(self,skill)
           return { true },self.inst.prefab ~= character and self.inst.prefab == "kana"  and skill and SKILLTREE_DEFS[skill]---  成功了 但是 其他角色依然可以 闷烧 
    end

    AddComponentPostInit("skilltreeupdater",function(self)
		SKILLTREE_DEFS = require("prefabs/skilltree_defs").SKILLTREE_DEFS[character]
		Utils.FnDecorator(self,"IsActivated",IsActivatedBefore)
    end)

    local function Init(inst)
        --偷个懒，这里直接解锁所有技能，也没管解锁先后顺序和技能冲突，如果之后又什么问题就再把冲突的技能排除掉
		if inst.prefab == "kana" then 
			for _,data in pairs(SKILLTREE_DEFS) do
				if data.onactivate  then   --- 这个代码限制了  火女的科技树 闷烧的能力 
					data.onactivate(inst)   --- 恶魔人载入这个会提示 错误 无法载入人物 
				end
			end
		end
    end

    AddPlayerPostInit(function(inst)
        if inst.prefab == character then return end
        if not TheWorld.ismastersim then return end
        inst:DoTaskInTime(0,Init)
    end)
	
	
end
--这个函数是开启某个角色后会载入对应角色名称的技能树 -- 目前已经被我限制成为只能某个指定人物名称 kana 才能开启
----------------------------------------------------------------------------------------------------

local function OrderByPriority(l,r)
    return (l.action and l.action.priority or 0) > (r.action and r.action.priority or 0)
end

---追加鼠标行为，不方便hook pointspecialactionsfn，伍迪、大力士这种角色会把这个变量清空
---@param getactionfn function (inst,target,pos,useitem,right,bufs)
function AAB_AddClickAction(getactionfn)
    local function NoEquipActivator(bufs,self,pos,target,right)
        --当玩家装备aoetargeting可施法武器的时候，会导致不管是施法还是这个动作都无法执行，我希望最少有一个能执行
        local item = self.inst.replica.inventory and self.inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
        if not (item and item.components.aoetargeting and item.components.aoetargeting:IsEnabled()) then
            local useitem = self.inst.replica.inventory and self.inst.replica.inventory:GetActiveItem()
            local act,pos2 = getactionfn(self.inst,target,pos,useitem,right,bufs)
            if act then
                local actions = { act }
                for _,buf in ipairs(self:SortActionList(actions,pos2 or pos)) do
                    table.insert(bufs,buf)
                end
                table.sort(bufs,OrderByPriority) --顺便和原来的一起排个序
            end
        end
    end

    AddComponentPostInit("playeractionpicker",function(self)
	

        local OldGetLeftClickActions = self.GetLeftClickActions
        self.GetLeftClickActions = function(self,position,target,...)
            local bufs = OldGetLeftClickActions(self,position,target,...)
            NoEquipActivator(bufs,self,position,target,false)
            return bufs
        end

		
        local OldGetRightClickActions = self.GetRightClickActions
        self.GetRightClickActions = function(self,position,target,...)
            local bufs = OldGetRightClickActions(self,position,target,...)
            NoEquipActivator(bufs,self,position,target,true)
            return bufs
        end
		
    end)
	

	
end
---追加鼠标行为，不方便hook pointspecialactionsfn，伍迪、大力士这种角色会把这个变量清空

--- 特效动作
---@param getactionfn function (inst,pos,useitem,right,bufs,usereticulepos)
function AAB_AddSpecialAction(getactionfn)
    AddComponentPostInit("playeractionpicker",function(self)
        local OldGetPointSpecialActions = self.GetPointSpecialActions
        self.GetPointSpecialActions = function(self,pos,useitem,right,usereticulepos,...)
            local bufs = OldGetPointSpecialActions(self,pos,useitem,right,usereticulepos,...)
            local actions,pos2 = getactionfn(self.inst,pos,useitem,right,bufs,usereticulepos,...)
            for _,buf in ipairs(self:SortActionList(actions,usereticulepos and pos2 or pos,useitem)) do
                table.insert(bufs,buf)
            end
            return bufs
        end
    end)
end


 --and inst:HasTag("kana")条件必须名称是kana
    modimport "modmain/abilities"
	modimport "modmain/debug" -- TODO


----------------------------------------------------------------------------------------------------

local fx = require("fx")
for _,v in ipairs(FX_DATA) do
    v.bank = v.bank or v.name
    v.build = v.build or v.name
    v.anim = v.anim or "idle"

    table.insert(Assets,Asset("ANIM","anim/" .. v.build .. ".zip"))
    table.insert(fx,v)
end

for actiontype,components in pairs(AAB_COMPONENT_ACTIONS) do
    for component,fns in pairs(components) do
        AddComponentAction(actiontype,component,function(...)
            for _,fn in ipairs(fns) do fn(...) end
        end)
    end
end

local containers = require("containers")
local params = containers.params
for k,v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS,v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end

----------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------
--代码是引用 全能力 作者  绯世行 的 所有能力 3366313760 --代码是引用 全能力 作者  绯世行 的 所有能力 3366313760 


---来自深渊 雷哥的能力 火葬炮！---来自深渊 雷哥的能力 火葬炮！---来自深渊 雷哥的能力 火葬炮！---来自深渊 雷哥的能力 火葬炮！
---来自深渊 雷哥的能力 火葬炮！---来自深渊 雷哥的能力 火葬炮！---来自深渊 雷哥的能力 火葬炮！---来自深渊 雷哥的能力 火葬炮！

TUNING.REGBOMB_HELATH = 40
TUNING.REGBOMB_HUNGER = 40
TUNING.REGBOMB_SANITY = 40
TUNING.REGBOMB_DAMAGE = 1000
TUNING.REGBOMB_CONSUME = 1--消耗头盔的能量
TUNING.REGERMAXTIME = 0
TUNING.ABYSSUSES = 1---未知



local REGBOMB = Action({distance = 999999})---和射程有巨大关系的火焰多少有关系
REGBOMB.id = "REGBOMB"
REGBOMB.str = "bomb"
REGBOMB.fn = function(act)
    if act.doer ~= nil 
        and act.doer:HasTag("regerbomb") 
        and act.target ~= nil 
        and act.doer:HasTag('player') 
        and act.target.components.combat 
        and act.target.components.health then
        
        local headitem = nil
        if act.doer.components.inventory then
            headitem = act.doer.components.inventory.equipslots[GLOBAL.EQUIPSLOTS.HEAD]
        elseif act.doer.replica.inventory then
            headitem = act.doer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HEAD)
        end
        
        act.doer.target = act.target
        act.doer.components.health:DoDelta(-TUNING.REGBOMB_HELATH)--消耗生命
        --act.doer.components.hunger:DoDelta(-TUNING.REGBOMB_HUNGER)--消耗饱食
        act.doer.components.sanity:DoDelta(-TUNING.REGBOMB_SANITY)--消耗精神
        --headitem.components.fueled:DoDelta(-TUNING.REGBOMB_CONSUME)--消耗头盔的能量
        
        return true
    else
        return false
    end
end

AddAction(REGBOMB)
---头盔丢在地上会消失


--去掉如下代码将没有火葬炮 而且头盔丢地上依然消失
AddComponentAction("SCENE", "combat", function(inst, doer, actions, right)
    if right then
        if doer:HasTag("regerbomb") 
            and inst.replica.health ~= nil 
            and not inst:HasTag("player") 
            and doer.replica.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS) == nil then
            
            table.insert(actions, GLOBAL.ACTIONS.REGBOMB)
        end
    end
end)
--去掉如下代码将没有火葬炮 而且头盔丢地上依然消失


local state_regbomb = GLOBAL.State{
    name = "regbomb",
    tags = { "doing", "busy" },
    
    onenter = function(inst)
        inst.components.locomotor:Stop()
        
        inst.AnimState:OverrideSymbol("swap_object", "reagerweapon", "reagerweapon")
        inst.AnimState:SetPercent("dart_pre", 1)
        
        inst.sg.statemem.action = inst.bufferedaction
        inst.sg:SetTimeout(2)
        
        if not GLOBAL.TheWorld.ismastersim then
            inst:PerformPreviewBufferedAction()
        end
    end,
    
    timeline = {
        GLOBAL.TimeEvent(0 * GLOBAL.FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/bishop/charge")
        end),
        
        GLOBAL.TimeEvent(8 * GLOBAL.FRAMES, function(inst)
            if GLOBAL.TheWorld.ismastersim then
                inst:PerformBufferedAction()
            end
        end),
        
        GLOBAL.TimeEvent(15 * GLOBAL.FRAMES, function(inst)
            inst.sg:RemoveStateTag("busy")
            inst.SoundEmitter:PlaySound("dontstarve/creatures/slurtle/explode")
            
            if GLOBAL.TheWorld.ismastersim then
			
			
--发射投射物 inst 通常指当前实体（比如一个怪物、物品或技能释放者）regerweapon 可能是inst拥有的一个武器 / 技能组件（比如 "远程武器"）
--regerweapon存在于\scripts\prefabs\regerweapon.lua
inst.regerweapon.components.weapon:LaunchProjectile(inst.regerweapon, inst.target, inst)
--通过武器组件的LaunchProjectile方法发射投射物，参数分别是：武器本身、目标（inst.target）、发射者（inst）
				
				
				--对范围内玩家产生视觉 / 震动效果
                for i, v in ipairs(GLOBAL.AllPlayers) do
                    local distSq = v:GetDistanceSqToInst(inst)
                    local k = math.max(0, math.min(1, distSq / 1600))
                    local intensity = k * (k - 2) + 1
                    
                    if intensity > 0 then
                        v:ScreenFlash(intensity)
                        v:ShakeCamera(GLOBAL.CAMERASHAKE.FULL, .7, .02, intensity / 2)
                    end
                end
				--对范围内玩家产生视觉 / 震动效果
				
				--向当前实体inst推送一个名为 "yawn"（打哈欠）的事件
                inst:PushEvent("yawn", { grogginess = 3, knockoutduration = 2 }) 
				--昏沉度越高越容易导致瞬间昏迷 4的时候如果人物本身就昏沉度很高就会突然昏过去 --比如一个人物昏沉度5 如果射2发3昏迷  就是6 导致突破极限5 昏过去  这里的击晕是被击晕 会昏过去 
				--附带参数：grogginess（昏沉度 = 4）、knockoutduration（击晕持续时间 = 10）
            end
        end),
    },
    
    onupdate = function(inst)
        if not GLOBAL.TheWorld.ismastersim then
            if inst:HasTag("doing") then
                if inst.entity:FlattenMovementPrediction() then
                    inst.sg:GoToState("idle", "noanim")
                end
            elseif inst.bufferedaction == nil then
                inst.sg:GoToState("idle", true)
            end
        end
    end,
    
    ontimeout = function(inst)
        if not GLOBAL.TheWorld.ismastersim then
            inst:ClearBufferedAction()
        end
        inst.sg:GoToState("idle")
    end,
    
    onexit = function(inst)
        if inst.bufferedaction == inst.sg.statemem.action then
            inst:ClearBufferedAction()
        end
        inst.sg.statemem.action = nil
    end,
}
--有提示火葬炮 但是无法使用 丢地上依然消失
AddStategraphState("wilson", state_regbomb)
AddStategraphState("wilson_client", state_regbomb)
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.REGBOMB, "regbomb"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.REGBOMB, "regbomb"))
--有提示火葬炮 但是无法使用 丢地上依然消失

---来自深渊 雷哥的能力 火葬炮！---来自深渊 雷哥的能力 火葬炮！---来自深渊 雷哥的能力 火葬炮！---来自深渊 雷哥的能力 火葬炮！
---来自深渊 雷哥的能力 火葬炮！---来自深渊 雷哥的能力 火葬炮！---来自深渊 雷哥的能力 火葬炮！---来自深渊 雷哥的能力 火葬炮！