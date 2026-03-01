name = "Ange"
description = "Eat omelet upgrade,max level:50,R Check Level"
author = "終焉さくら"
version = "1.1.2"

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

configuration_options = 
{
    {
        name = "Language",
        label = "Language",
        options =   {
                        {description = "English", data = false},
                        {description = "Chinese", data = true},
                    },
        default = false,
    },
	{
		name 	= "config_wf",
		label 	= "Gun Damage",
		options =
		{
			{description = "50", 			data = 50},
			{description = "100", 			data = 100},
			{description = "150", 			data = 150},
			{description = "200", 			data = 200},
		},
        default = 100,
	}
}