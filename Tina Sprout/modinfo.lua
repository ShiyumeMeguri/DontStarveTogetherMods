name = "Tina Sprout"
description = [[ティナちゃんの声に癒されたました...
Skill:
Z: View information
R: Short-term acceleration, enhance the next ax338 attack
C: Place a trap, deal damage to the enemies encountered and stun for 1.5 seconds.
V: Shoot a powerful bullet
Because of the owl factor, the daytime light is glaring.
She can sleep during the day, but she can't sleep at night.]]
author = "終焉さくら"
version = "1.1.0"

forumthread = ""

api_version_dst = 10

dst_compatible = true

dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false

all_clients_require_mod = true 

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {
"character",
}

all_key = {
            {description="TAB", data = 9},
            {description="KP_PERIOD", data = 266},
            {description="KP_DIVIDE", data = 267},
            {description="KP_MULTIPLY", data = 268},
            {description="KP_MINUS", data = 269},
            {description="KP_PLUS", data = 270},
            {description="KP_ENTER", data = 271},
            {description="KP_EQUALS", data = 272},
            {description="MINUS", data = 45},
            {description="EQUALS", data = 61},
            {description="SPACE", data = 32},
            {description="ENTER", data = 13},
            {description="ESCAPE", data = 27},
            {description="HOME", data = 278},
            {description="INSERT", data = 277},
            {description="DELETE", data = 127},
            {description="END", data   = 279},
            {description="PAUSE", data = 19},
            {description="PRINT", data = 316},
            {description="CAPSLOCK", data = 301},
            {description="SCROLLOCK", data = 302},
            {description="RSHIFT", data = 303},
            {description="LSHIFT", data = 304},
            {description="RCTRL", data = 305}, 
            {description="LCTRL", data = 306}, 
            {description="RALT", data = 307}, 
            {description="LALT", data = 308}, 
            {description="ALT", data = 400},
            {description="CTRL", data = 401},
            {description="SHIFT", data = 402},
            {description="BACKSPACE", data = 8},
            {description="PERIOD", data = 46},
            {description="SLASH", data = 47},
            {description="LEFTBRACKET", data     = 91},
            {description="BACKSLASH", data     = 92},
            {description="RIGHTBRACKET", data = 93},
            {description="TILDE", data = 96},
            {description="A", data = 97},
            {description="B", data = 98},
            {description="C", data = 99},
            {description="D", data = 100},
            {description="E", data = 101},
            {description="F", data = 102},
            {description="G", data = 103},
            {description="H", data = 104},
            {description="I", data = 105},
            {description="J", data = 106},
            {description="K", data = 107},
            {description="L", data = 108},
            {description="M", data = 109},
            {description="N", data = 110},
            {description="O", data = 111},
            {description="P", data = 112},
            {description="Q", data = 113},
            {description="R", data = 114},
            {description="S", data = 115},
            {description="T", data = 116},
            {description="U", data = 117},
            {description="V", data = 118},
            {description="W", data = 119},
            {description="X", data = 120},
            {description="Y", data = 121},
            {description="Z", data = 122},
            {description="F1", data = 282},
            {description="F2", data = 283},
            {description="F3", data = 284},
            {description="F4", data = 285},
            {description="F5", data = 286},
            {description="F6", data = 287},
            {description="F7", data = 288},
            {description="F8", data = 289},
            {description="F9", data = 290},
            {description="F10", data = 291},
            {description="F11", data = 292},
            {description="F12", data = 293},
 
            {description="UP", data = 273},
            {description="DOWN", data = 274},
            {description="RIGHT", data = 275},
            {description="LEFT", data = 276},
            {description="PAGEUP", data = 280},
            {description="PAGEDOWN", data = 281},
 
            {description="0", data = 48},
            {description="1", data = 49},
            {description="2", data = 50},
            {description="3", data = 51},
            {description="4", data = 52},
            {description="5", data = 53},
            {description="6", data = 54},
            {description="7", data = 55},
            {description="8", data = 56},
            {description="9", data = 57},
        }

configuration_options = {
	{
        name = "AX338",
        label = "AX338",
        hover = "AX338のキー.",
        options = all_key,
        default = 118,
    },
	{
        name = "KUROIKAZE",
        label = "黒い風",
        hover = "黒い風のキー.",
        options =all_key,
		default = 114,
    },
	{
        name = "TEISATUWANA",
        label = "偵察の罠",
        hover = "スカウトトラップのキー.",
        options =all_key,
        default = 99,
    },
	{
        name = "INFO",
        label = "情報を見る",
        hover = "情報のキー.",
        options =all_key,
        default = 122,
    },
}