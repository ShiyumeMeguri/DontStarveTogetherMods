PrefabFiles = {
	"ria",
	"ria_none",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/ria.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/ria.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/ria.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/ria.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/ria_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/ria_silho.xml" ),

    Asset( "IMAGE", "bigportraits/ria.tex" ),
    Asset( "ATLAS", "bigportraits/ria.xml" ),
	
	Asset( "IMAGE", "images/map_icons/ria.tex" ),
	Asset( "ATLAS", "images/map_icons/ria.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ria.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ria.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_ria.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_ria.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_ria.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_ria.xml" ),
	
    Asset( "IMAGE", "bigportraits/ria_none.tex" ),
    Asset( "ATLAS", "bigportraits/ria_none.xml" ),

}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

STRINGS.CHARACTER_TITLES.ria = "Ria"
STRINGS.CHARACTER_NAMES.ria = "Ria"
STRINGS.CHARACTER_DESCRIPTIONS.ria = "*天才バッカー\n*無口の少女\n*無関心"
STRINGS.CHARACTER_QUOTES.ria = "\"Ria\""

STRINGS.CHARACTERS.RIA = require "speech_wilson"

STRINGS.NAMES.RIA = "Ria"

AddMinimapAtlas("images/map_icons/ria.xml")

AddModCharacter("ria", "FEMALE")

