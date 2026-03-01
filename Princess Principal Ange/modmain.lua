modimport("scripts/ange_util/ange_util.lua")

PrefabFiles = {
	"ange",
	"ange_none",
	"caver",
	"caver_light",
	"omelet",
	"ammo",
	"wf",
	"bullet",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/ange.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/ange.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/ange.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/ange.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/ange_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/ange_silho.xml" ),

    Asset( "IMAGE", "bigportraits/ange.tex" ),
    Asset( "ATLAS", "bigportraits/ange.xml" ),
	
	Asset( "IMAGE", "images/map_icons/ange.tex" ),
	Asset( "ATLAS", "images/map_icons/ange.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ange.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ange.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_ange.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_ange.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_ange.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_ange.xml" ),
	
    Asset( "IMAGE", "bigportraits/ange_none.tex" ),
    Asset( "ATLAS", "bigportraits/ange_none.xml" ),
	
	Asset( "ATLAS", "images/hud/angetab.xml" ),
	Asset( "IMAGE", "images/hud/angetab.tex" ),
	
	Asset( "IMAGE", "images/inventoryimages/caver.tex" ),
	Asset( "ATLAS", "images/inventoryimages/caver.xml"),
	
	Asset( "IMAGE", "images/inventoryimages/caver_light.tex" ),
	Asset( "ATLAS", "images/inventoryimages/caver_light.xml"),
	
	Asset( "IMAGE", "images/inventoryimages/omelet.tex" ),
	Asset( "ATLAS", "images/inventoryimages/omelet.xml" ),
	
	Asset("ATLAS", "images/inventoryimages/wf.xml"),
	Asset("ATLAS", "images/inventoryimages/ammo.xml"),
	Asset("ATLAS", "images/inventoryimages/bullet.xml"),

}

STRINGS 	= GLOBAL.STRINGS
RECIPETABS 	= GLOBAL.RECIPETABS
Recipe 		= GLOBAL.Recipe
TECH		= GLOBAL.TECH
Ingredient 	= GLOBAL.Ingredient

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local TECH = GLOBAL.TECH


_G = GLOBAL


if GetModConfigData("Language") == false then
STRINGS.NAMES.CAVER = "Caver"
STRINGS.RECIPE_DESC.CAVER = "Scientist Caver developed material"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.CAVER = "Anti-gravity black tech"

STRINGS.NAMES.CAVER_LIGHT = "Caver Light"
STRINGS.RECIPE_DESC.CAVER_LIGHT = "So hot!"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.CAVER_LIGHT = "True anti-gravity"

STRINGS.NAMES.OMELET = "Omelet"
STRINGS.RECIPE_DESC.OMELET = "Breakfast must be"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.OMELET = "It looks delicious."

STRINGS.NAMES.AMMO = ".455 Webley"
STRINGS.RECIPE_DESC.AMMO = "Ammo"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.AMMO = "Webley-Fosbery's bullet."

STRINGS.NAMES.WF = "Webley-Fosbery"
STRINGS.RECIPE_DESC.WF = "Designed by George V. Fosbery"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.WF = "Ange favorite to use the gun."

STRINGS.CHARACTER_TITLES.ange = "Ange"
STRINGS.CHARACTER_NAMES.ange = "Ange"
STRINGS.CHARACTER_DESCRIPTIONS.ange = "*Has Kay material\n*genius mind own technology\n*art wrist comes with a magic"
STRINGS.CHARACTER_QUOTES.ange = "\"Charlotte.\""

STRINGS.CHARACTERS.GENERIC.DESCRIBE.ange = 
{
	GENERIC = "This is Ange!",
	ATTACKER = "Ange is more suitable for guns",
	MURDERER = "Assassinate!",
	REVIVER = "Since birth, two words spy have been engraved on my forehead",
	GHOST = "This is the end of the spy.",
}

STRINGS.NAMES.ange = "Ange"
end

if GetModConfigData("Language") == true then
STRINGS.NAMES.CAVER = "凯沃物质"
STRINGS.RECIPE_DESC.CAVER = "科学家ケイバー博士开发的物质"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.CAVER = "牛顿的棺材板盖不住了"

STRINGS.NAMES.CAVER_LIGHT = "凯沃光"
STRINGS.RECIPE_DESC.CAVER_LIGHT = "好热！"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.CAVER_LIGHT = "真正的反重力"

STRINGS.NAMES.OMELET = "欧姆蛋"
STRINGS.RECIPE_DESC.OMELET = "早餐必备"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.OMELET = "看上去很美味."

STRINGS.NAMES.AMMO = ".455 Webley"
STRINGS.RECIPE_DESC.AMMO = "子弹"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.AMMO = "Webley-Fosbery的子弹."

STRINGS.NAMES.WF = "Webley-Fosbery"
STRINGS.RECIPE_DESC.WF = "由George V. Fosbery设计"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.WF = "Ange最爱使用的枪."

STRINGS.CHARACTER_TITLES.ange = "安洁"
STRINGS.CHARACTER_NAMES.ange = "安洁"
STRINGS.CHARACTER_DESCRIPTIONS.ange = "*拥有凯沃物质\n*天才头脑自带科技\n*艺术的手腕自带1级魔法"
STRINGS.CHARACTER_QUOTES.ange = "\"夏洛特.\""

STRINGS.CHARACTERS.GENERIC.DESCRIBE.ange = 
{
	GENERIC = "这是安洁!",
	ATTACKER = "安洁更适合用枪呢",
	MURDERER = "刺杀啊!",
	REVIVER = "从出生起我的额头上就刻了间谍两个字",
	GHOST = "这就是间谍的末路.",
}

STRINGS.NAMES.ange = "Ange"
end

local angetab = AddRecipeTab( "Ange", 995, "images/hud/angetab.xml", "angetab.tex", "ange_builder")

AddRecipe("caver",
{GLOBAL.Ingredient("gears", 2), GLOBAL.Ingredient("nightmarefuel", 2), GLOBAL.Ingredient("transistor", 1)},
angetab, TECH.NONE,
nil, nil, nil, nil, "ange_builder",
"images/inventoryimages/caver.xml", "caver.tex")

AddRecipe("caver_light",
{GLOBAL.Ingredient("caver", 1), GLOBAL.Ingredient("greengem", 2), GLOBAL.Ingredient("lifeinjector", 1), GLOBAL.Ingredient("thulecite", 2)},
angetab, TECH.NONE,
nil, nil, nil, nil, "ange_builder",
"images/inventoryimages/caver_light.xml", "caver_light.tex")

AddRecipe("omelet",
{GLOBAL.Ingredient("bird_egg", 2), GLOBAL.Ingredient("berries", 4)},
angetab, TECH.NONE,
nil, nil, nil, nil, "ange_builder",
"images/inventoryimages/omelet.xml", "omelet.tex")

	local tech_ammo    		= {SCIENCE = 0, MAGIC = 0, ANCIENT = 0}
	local cost_ammo			= {Ingredient("flint", 3), Ingredient("goldnugget", 1),Ingredient("gunpowder", 1)}
	TUNING.WF_DAMAGE = GetModConfigData("config_wf")

local ammo = Recipe("ammo",cost_ammo, RECIPETABS.WAR, tech_ammo,nil, nil, nil, 6, nil)

ammo.atlas = "images/inventoryimages/ammo.xml"


STRINGS.CHARACTERS.ANGE = require "speech_wilson"
 
STRINGS.NAMES.ANGE = "Ange"

AddMinimapAtlas("images/map_icons/ange.xml")

AddModCharacter("ange", "FEMALE")
