--初期化
local function FuckGlobalUsingMetatable()
	GLOBAL.setmetatable(env, {
		__index = function(t,k)
			if k~="PrefabFiles" and k~="Assets" and k~="clothing_exclude" then
				return GLOBAL[k] and GLOBAL[k] or nil
			end
		end,
	})	
end
FuckGlobalUsingMetatable()
--BackPack
local containers = require("containers")
	local oldwidgetsetup = containers.widgetsetup
	containers.widgetsetup = function(container, prefab)
	if not prefab and container.inst.prefab == "kaban" then
	prefab = "krampus_sack" 
	elseif not prefab and container.inst.prefab == "syou_kaban" then
	prefab = "backpack"
	end
	oldwidgetsetup(container, prefab)
end
--プレハブ
PrefabFiles = {
	"sora",
	"dekiru",
	"kuma",
	"usagi",
	"hitsuji",
	"live_headwear",
	"uyoku",
	"neko_hat",
	"croquette",
	"bachi",
	"kaban",
	"syou_kaban",
}
--資源ファイル
Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/sora.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/sora.xml" ),
    Asset( "IMAGE", "bigportraits/sora.tex" ),
    Asset( "ATLAS", "bigportraits/sora.xml" ),
	Asset( "IMAGE", "images/map_icons/sora.tex" ),
	Asset( "ATLAS", "images/map_icons/sora.xml" ),
    Asset( "IMAGE", "images/avatars/avatar_sora.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_sora.xml" ),
    Asset( "IMAGE", "images/avatars/avatar_ghost_sora.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_sora.xml" ),
    Asset( "IMAGE", "images/avatars/self_inspect_sora.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_sora.xml" ),
    Asset( "IMAGE", "images/names_gold_sora.tex" ),
    Asset( "ATLAS", "images/names_gold_sora.xml" ),
    Asset( "IMAGE", "images/names_sora.tex" ),
    Asset( "ATLAS", "images/names_sora.xml" ),
    Asset( "IMAGE", "bigportraits/sora_none.tex" ),
    Asset( "ATLAS", "bigportraits/sora_none.xml" ),

	-------------------------------------------------
	
    Asset( "IMAGE", "images/gui/hud.tex"),
    Asset( "ATLAS", "images/gui/hud.xml"),
    Asset( "IMAGE", "images/gui/hane.tex"),
    Asset( "ATLAS", "images/gui/hane.xml"),
    Asset( "IMAGE", "images/gui/health1.tex"),
    Asset( "ATLAS", "images/gui/health1.xml"),
    Asset( "IMAGE", "images/gui/health2.tex"),
    Asset( "ATLAS", "images/gui/health2.xml"),
	
	Asset( "ANIM", "anim/sora.zip" ),
	Asset( "ANIM", "anim/ghost_sora_build.zip" ),
	Asset( "ANIM", "anim/sora_health.zip" ),
	Asset( "ANIM", "anim/sora_hunger.zip" ),
	Asset( "ANIM", "anim/sora_sanity.zip" ),
    Asset( "ANIM", "anim/hunger_health_pulse.zip"),
	Asset( "ANIM", "anim/dekiru.zip" ),
	Asset( "ANIM", "anim/hitsuji.zip" ),
	Asset( "ANIM", "anim/kuma.zip" ),
	Asset( "ANIM", "anim/usagi.zip" ),
	Asset( "ANIM", "anim/live_headwear.zip" ),
	Asset( "ANIM", "anim/uyoku.zip" ),
	Asset( "ANIM", "anim/neko_hat.zip" ),
	Asset( "ANIM", "anim/croquette.zip" ),
	Asset( "ANIM", "anim/bachi.zip" ),
	Asset( "ANIM", "anim/swap_bachi.zip" ),
	Asset( "ANIM", "anim/kaban.zip" ),
	Asset( "ANIM", "anim/swap_kaban.zip" ),
	Asset( "ANIM", "anim/syou_kaban.zip" ),
	Asset( "ANIM", "anim/swap_syoukaban.zip" ),
	
	Asset( "IMAGE", "images/inventoryimages/dekiru.tex"),
	Asset( "ATLAS", "images/inventoryimages/dekiru.xml"),
	Asset( "IMAGE", "images/inventoryimages/hitsuji.tex"),
	Asset( "ATLAS", "images/inventoryimages/hitsuji.xml"),
	Asset( "IMAGE", "images/inventoryimages/kuma.tex"),
	Asset( "ATLAS", "images/inventoryimages/kuma.xml"),
	Asset( "IMAGE", "images/inventoryimages/usagi.tex"),
	Asset( "ATLAS", "images/inventoryimages/usagi.xml"),
	Asset( "IMAGE", "images/inventoryimages/live_headwear.tex"),
	Asset( "ATLAS", "images/inventoryimages/live_headwear.xml"),
	Asset( "IMAGE", "images/inventoryimages/soratab.tex"),
	Asset( "ATLAS", "images/inventoryimages/soratab.xml"),
	Asset( "IMAGE", "images/inventoryimages/neko_hat.tex"),
	Asset( "ATLAS", "images/inventoryimages/neko_hat.xml"),
	Asset( "IMAGE", "images/inventoryimages/croquette.tex"),
	Asset( "ATLAS", "images/inventoryimages/croquette.xml"),
	Asset( "IMAGE", "images/inventoryimages/bachi.tex"),
	Asset( "ATLAS", "images/inventoryimages/bachi.xml"),
	Asset( "IMAGE", "images/inventoryimages/kaban.tex"),
	Asset( "ATLAS", "images/inventoryimages/kaban.xml"),
	Asset( "IMAGE", "images/inventoryimages/syou_kaban.tex"),
	Asset( "ATLAS", "images/inventoryimages/syou_kaban.xml"),
	
	Asset( "IMAGE", "images/bg_spiral_fill1.tex"),
	Asset( "ATLAS", "images/bg_spiral_fill1.xml"),
	Asset( "IMAGE", "images/bg_spiral_fill2.tex"),
	Asset( "ATLAS", "images/bg_spiral_fill2.xml"),
	Asset( "IMAGE", "images/bg_spiral_fill3.tex"),
	Asset( "ATLAS", "images/bg_spiral_fill3.xml"),
	Asset( "IMAGE", "images/bg_spiral_fill4.tex"),
	Asset( "ATLAS", "images/bg_spiral_fill4.xml"),
	Asset( "IMAGE", "images/bg_spiral_fill5.tex"),
	Asset( "ATLAS", "images/bg_spiral_fill5.xml"),
	Asset( "IMAGE", "images/bg_spiral_fill6.tex"),
	Asset( "ATLAS", "images/bg_spiral_fill6.xml"),
	Asset( "IMAGE", "images/bg_spiral_fill7.tex"),
	Asset( "ATLAS", "images/bg_spiral_fill7.xml"),
	Asset( "IMAGE", "images/bg_spiral_fill8.tex"),
	Asset( "ATLAS", "images/bg_spiral_fill8.xml"),
}
--設定
TUNING.HANEAPLHA = GetModConfigData("HaneAlpha")
TUNING.HANEQUANTITY = GetModConfigData("HaneQuantity")
TUNING.SORA_LANGUAGES = GetModConfigData("SoraLanguages")
TUNING.TENSHIKEY = GetModConfigData("TenshiKey")
TUNING.NEBOUKEY = GetModConfigData("NebouKey")
--せつめいもじ
STRINGS.CHARACTER_TITLES.sora = "金城そら"
STRINGS.CHARACTER_NAMES.sora = "そら"
STRINGS.CHARACTER_DESCRIPTIONS.sora = "*コロッケ大好き\n*コロッケ食べたい\n*コロッケおいしい"
STRINGS.CHARACTER_QUOTES.sora = "\"Believe In...Myself\""
STRINGS.NAMES.SORA = "Sora"

STRINGS.NAMES.DEKIRU = "よくできました"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.DEKIRU = "これは奨励です"

STRINGS.NAMES.KUMA = "熊のぬいぐるみ"
STRINGS.RECIPE_DESC.KUMA = "もしかして走れるかなぁ"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.KUMA = "暖かいですね"

STRINGS.NAMES.HITSUJI = "羊のぬいぐるみ"
STRINGS.RECIPE_DESC.HITSUJI = "ふわふわ～"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HITSUJI = "雲みたい"

STRINGS.NAMES.USAGI = "うさぎのぬいぐるみ"
STRINGS.RECIPE_DESC.USAGI = "スピードが増えるか？"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.USAGI = "はやいぃぃ！"

STRINGS.NAMES.LIVE_HEADWEAR = "花飾り"
STRINGS.RECIPE_DESC.LIVE_HEADWEAR = "ライブ用と書いてある"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.LIVE_HEADWEAR = "きれいですか"

STRINGS.NAMES.CROQUETTE = "コロッケ"
STRINGS.RECIPE_DESC.CROQUETTE = "コロッケ食べたい～\nコロッケ大好き\nおいしいコロッケ"

STRINGS.NAMES.NEKO_HAT = "子猫ぼうし"
STRINGS.RECIPE_DESC.NEKO_HAT = "とてもかわいいのぼうし"

STRINGS.NAMES.BACHI = "ばち"
STRINGS.RECIPE_DESC.BACHI = "太鼓のばち"

STRINGS.NAMES.KABAN = "ランドセル"
STRINGS.RECIPE_DESC.KABAN = "小学生は最高だぜ！"

STRINGS.NAMES.SYOU_KABAN = "かばん"
STRINGS.RECIPE_DESC.SYOU_KABAN = "小学校行くとき用のかばん"

AddMinimapAtlas("images/map_icons/sora.xml")

AddModCharacter("sora", "FEMALE")

--そうぞう物　　　　スタート
SoraTab = AddRecipeTab("Sora", 137, "images/inventoryimages/soratab.xml", "soratab.tex", "sora_build")

AddRecipe("kuma",
{Ingredient("sewing_kit", 1),Ingredient("dekiru", 22, "images/inventoryimages/dekiru.xml")}, 
SoraTab, TECH.NONE,
nil, nil, nil, nil, "sora_build",
"images/inventoryimages/kuma.xml", "kuma.tex")

AddRecipe("hitsuji",
{Ingredient("sewing_kit", 1),Ingredient("dekiru", 22, "images/inventoryimages/dekiru.xml")}, 
SoraTab, TECH.NONE,
nil, nil, nil, nil, "sora_build",
"images/inventoryimages/hitsuji.xml", "hitsuji.tex")

AddRecipe("usagi",
{Ingredient("sewing_kit", 1),Ingredient("dekiru", 18, "images/inventoryimages/dekiru.xml")}, 
SoraTab, TECH.NONE,
nil, nil, nil, nil, "sora_build",
"images/inventoryimages/usagi.xml", "usagi.tex")

AddRecipe("live_headwear",
{Ingredient("dekiru", 10, "images/inventoryimages/dekiru.xml"), Ingredient("flowerhat", 1)}, 
SoraTab, TECH.NONE,
nil, nil, nil, nil, "sora_build",
"images/inventoryimages/live_headwear.xml", "live_headwear.tex")

AddRecipe("neko_hat",
{Ingredient("dekiru", 20, "images/inventoryimages/dekiru.xml"), Ingredient("tophat", 1)}, 
SoraTab, TECH.NONE,
nil, nil, nil, nil, "sora_build",
"images/inventoryimages/neko_hat.xml", "neko_hat.tex")

AddRecipe("croquette",
{Ingredient("dekiru", 12, "images/inventoryimages/dekiru.xml")}, 
SoraTab, TECH.NONE,
nil, nil, nil, nil, "sora_build",
"images/inventoryimages/croquette.xml", "croquette.tex")

AddRecipe("bachi",
{Ingredient("dekiru", 3, "images/inventoryimages/dekiru.xml"), Ingredient("twigs", 5), Ingredient("axe", 1)}, 
SoraTab, TECH.NONE,
nil, nil, nil, nil, "sora_build",
"images/inventoryimages/bachi.xml", "bachi.tex")

AddRecipe("kaban",
{Ingredient("dekiru", 50, "images/inventoryimages/dekiru.xml"), Ingredient("backpack", 1)}, 
SoraTab, TECH.NONE,
nil, nil, nil, nil, "sora_build",
"images/inventoryimages/kaban.xml", "kaban.tex")

AddRecipe("syou_kaban",
{Ingredient("dekiru", 1, "images/inventoryimages/dekiru.xml"), Ingredient("backpack", 1)}, 
SoraTab, TECH.NONE,
nil, nil, nil, nil, "sora_build",
"images/inventoryimages/syou_kaban.xml", "syou_kaban.tex")
--そうぞう物　　　エンド

--キャラクターのアクション
local Nebou = AddAction("NEBOU", "眠る", function(act)
	if act.invobject and act.invobject.components.dakimakura then
        return act.invobject.components.dakimakura:nebou(act.invobject,act.doer)
    end
end)
AddComponentAction("INVENTORY", "dakimakura", function(inst, doer, actions)table.insert(actions, GLOBAL.ACTIONS.NEBOU)end)
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler( GLOBAL.ACTIONS.NEBOU, "doshortaction" ))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler( GLOBAL.ACTIONS.NEBOU, "doshortaction" ))
--空のヘルスのフレーム
AddClassPostConstruct("widgets/controls", function(self)
	local Hane = require "widgets/hane"
	local SoraHealth = require "widgets/sorahealth"
	if ThePlayer.prefab == "sora" and self.owner then
		self.hane = {}
		for k = 1, TUNING.HANEQUANTITY do
			ThePlayer:DoTaskInTime(math.random() * 10, function()
				self.hane[k] = self.bottom_root:AddChild(Hane("images/gui/hane.xml", "hane"..(math.ceil(math.random()*4))..".tex", 0,800,0))
			end)
        end
		self.health1 = self.bottom_root:AddChild(SoraHealth("images/gui/health1.xml", "health1.tex", 5,94,0, false))
		self.health1:SetScale(0.15, 0.15, 0.15)
		self.health2 = self.bottom_root:AddChild(SoraHealth("images/gui/health2.xml", "health2.tex", 5,95,0, true))
		self.health2:SetScale(0.15, 0.15, 0.15)
	end
end)
--属性アイコン
AddClassPostConstruct("widgets/statusdisplays", function(class, owner)
	if ThePlayer.prefab == "sora" then
		class.brain.anim:GetAnimState():SetBuild("sora_sanity")
		class.brain.anim:SetPosition(-336, -500, 0)
		class.brain.anim:SetScale(0.6, 0.6, 0.6)
		class.brain.num:SetPosition(-336, -500, 0)
		class.brain.warning:SetPosition(-336, -500, 0)
		class.brain.warning:SetScale(0.6, 0.6, 0.6)
		
		class.heart.anim:GetAnimState():SetBuild("sora_health")
		class.heart.anim:SetPosition(-323, -535, 0)
		class.heart.anim:SetScale(0.9, 0.9, 0.9)
		class.heart.num:SetPosition(-643, -535, 0)
		
		class.stomach.anim:GetAnimState():SetBuild("sora_hunger")
		class.stomach.anim:SetPosition(-836, -560, 0)
		class.stomach.anim:SetScale(0.6, 0.6, 0.6)
		class.stomach.num:SetPosition(-836, -560, 0)
		class.stomach.warning:SetPosition(-836, -560, 0)
		class.stomach.warning:SetScale(0.6, 0.6, 0.6)
		
		ThePlayer:DoPeriodicTask(0, function() 
		class.heart.warning:Hide()
		class.brain.pulse:Hide()
		class.heart.pulse:Hide()
		class.stomach.pulse:Hide()
		end)
	end
end)
--空のGUI
AddClassPostConstruct("widgets/inventorybar", function(class, owner)
	if ThePlayer.prefab == "sora" then
		class.bg:SetTexture("images/gui/hud.xml", "inventory_bg.tex")
		class.bgcover:Hide()
	end
end)
--正気度、ヘルス、飢餓のフレーム
AddClassPostConstruct("widgets/sanitybadge", function(class, owner)
	if ThePlayer.prefab == "sora" then
		class.topperanim:Hide()
		class.sanityarrow:SetPosition(-336, -500, 0)
	end 
end)
AddClassPostConstruct("widgets/healthbadge", function(class, owner)
	if ThePlayer.prefab == "sora" then
	class.topperanim:Hide() class.sanityarrow:SetPosition(-639, -535, 0)
		local temp = false
		ThePlayer:DoPeriodicTask(0, function()
			if ThePlayer:HasTag("tenshi") and temp == false then
				class.sanityarrow:GetAnimState():PlayAnimation("arrow_loop_decrease", true)
				class.sanityarrow:GetAnimState():SetMultColour(1, 0, 0, 1)
				temp = true
			elseif not ThePlayer:HasTag("tenshi") then
				class.sanityarrow:GetAnimState():PlayAnimation("neutral") 
				temp = false
			end
		end)
	end
end)
AddClassPostConstruct("widgets/hungerbadge", function(class, owner)
	if ThePlayer.prefab == "sora" then
		class.hungerarrow:SetPosition(-836, -560, 0)
	end 
 end)

--フレンドリー
AddStategraphPostInit("bird", function(sg)
	local old = sg.events.flyaway.fn
	local function RecheckForThreat(inst)
		local busy = inst.sg:HasStateTag("sleeping") or inst.sg:HasStateTag("busy") or inst.sg:HasStateTag("flying")
		if not busy then
			local threat = GLOBAL.FindEntity(inst, 5, nil, nil, {'notarget', 'sora_build'}, {'player'})
			return threat ~= nil or GLOBAL.TheWorld.state.isnight
		end
	end
	sg.events.flyaway.fn = function(inst)
		if RecheckForThreat(inst) then
			old(inst)
		end
	end
end)
--天使モード	
AddModRPCHandler("sora", "TENSHIMODE", function(inst)
if inst:HasTag("playerghost") and inst.prefab ~= "sora" then return end
if inst:HasTag("kaban") or inst:HasTag("syou_kaban") then inst.components.talker:Say("かばんを外してください") return end
	if inst.transformed then
			inst:AddTag("tenshi")
			inst.components.talker:Say([[今のレベルは：]]..inst.level..
			[[ 
			Exp:]]..inst.sora_exp..[[/]]..inst.level)
			inst.components.locomotor:SetExternalSpeedMultiplier(inst, "tenshimode", 1.5)
			inst.components.health.absorb = 0
			inst.components.combat.damagemultiplier = 1.3
			inst.components.hunger:SetRate(0)
			inst.components.health:StartRegen(-0.5, 1)
			inst.AnimState:OverrideSymbol("swap_body", "uyoku", "swap_body")
		else
			inst:RemoveTag("tenshi")
			inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "tenshimode")
			inst.components.health.absorb = 0.3
			inst.components.health:StopRegen()
			inst.components.combat.damagemultiplier = 0.7
			inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE)
			inst.components.health:StopRegen()
			inst.AnimState:ClearOverrideSymbol("swap_body", "uyoku", "swap_body")
	end
inst.transformed = not inst.transformed
return true
end)
--眠る
AddModRPCHandler("sora", "NEBOU", function(inst)
	if not inst:HasTag("playerghost") and inst.prefab == "sora" then
		if inst.seisin == false then
			inst:PushEvent("yawn", { grogginess = 4 + math.random() * 5 })
			else
			inst.components.talker:Say("また寝たくない...")
		end
	end
end)
--日本語
local t = {}
if TUNING.SORA_LANGUAGES == 1 then 
LoadPOFile("scripts/languages/japanese.po", "ja")
t.PO = GLOBAL.LanguageTranslator.languages["ja"]
	if rawget(GLOBAL,"GAME_MODES") and STRINGS.UI.GAMEMODES then
		for i,v in pairs(GLOBAL.GAME_MODES) do
			for ii,vv in pairs(STRINGS.UI.GAMEMODES) do
				if v.text==vv then
					GLOBAL.GAME_MODES[i].text = t.PO["STRINGS.UI.GAMEMODES."..ii] or GLOBAL.GAME_MODES[i].text
				end
				if v.description==vv then
					GLOBAL.GAME_MODES[i].description = t.PO["STRINGS.UI.GAMEMODES."..ii] or GLOBAL.GAME_MODES[i].description
				end
			end
		end
	end
	else
	t = {}
end
--Kill TGP
_G.Platform = GLOBAL.TheSim.RAILGetPlatform and GLOBAL.TheSim:RAILGetPlatform() 

if GLOBAL.TheSim.RAILGetPlatform and GLOBAL.TheSim:RAILGetPlatform() == "TGP" then
      for _, mod in ipairs(GLOBAL.ModManager.mods) do 
           if mod and mod.modinfo and mod.modinfo.id ~= "sora" then
                GLOBAL.KnownModIndex:Disable("sora")
          end
      end
     GLOBAL.Shutdown()
end