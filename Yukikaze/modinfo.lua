name = "雪風"
description = "ふんふんふーん、ここまでたどり着いたご褒美に、この幸運の雪風様が加わってやるのだ！光栄に思うのだ♪"
author = "終焉さくら"
version = "0.0.4.1"

forumthread = ""

api_version = 10

dst_compatible = true

dont_starve_compatible = false
reign_of_giants_compatible = false

all_clients_require_mod = true 

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {
"character",
}

configuration_options = {
{
	name = "gengo",
    label = "Language",
	hover   = "言語",
	options =   {
					{description = "English", data = 0},
					{description = "日本語", data = 1},
				},
	default = 1,
	},
}