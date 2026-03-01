--初期化
TUNING.Tina_G=GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})
--luaロード
PrefabFiles = {"tina",}
--マップのアイコンとティナの加入
AddMinimapAtlas("images/map_icons/tina.xml")
AddModCharacter("tina", "FEMALE")
--翻訳はここです
STRINGS.CHARACTER_TITLES.tina = "The Sniper"
STRINGS.CHARACTER_NAMES.tina = "Tina Sprout"
STRINGS.CHARACTER_DESCRIPTIONS.tina = "*AX338を持ている\n*Night vision\n*鳥類の友達"
STRINGS.CHARACTER_QUOTES.tina = "\"By day is too bright for me.\""
STRINGS.NAMES.TINA = "Tina"

STRINGS.NAMES.AX338 = "AX338"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.AX338 = "いつも守てくれて、ありがとう"
STRINGS.RECIPE_DESC.AX338 = "変だな、作っていないのに"
STRINGS.NAMES.AX338_DANSOU = "AX338用弾倉"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.AX338_DANSOU = "やはり...戦いしかないですか"
STRINGS.RECIPE_DESC.AX338_DANSOU = "10発がある"

AddRecipe("ax338_dansou",
		{Ingredient("gunpowder", 5), Ingredient("rocks", 5),Ingredient("goldnugget", 2)}, 
		RECIPETABS.WAR, TECH.NONE,
		nil, nil, nil, nil, "tina_build",
		"images/inventoryimages/ax338_dansou.xml", "ax338_dansou.tex")