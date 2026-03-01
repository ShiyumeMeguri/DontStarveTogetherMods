local assets =
{
	Asset( "ANIM", "anim/ange.zip" ),
	Asset( "ANIM", "anim/ghost_ange_build.zip" ),
}

local skins =
{
	normal_skin = "ange",
	ghost_skin = "ghost_ange_build",
}

local base_prefab = "ange"

local tags = {"ANGE", "CHARACTER"}

return CreatePrefabSkin("ange_none",
{
	base_prefab = base_prefab, 
	skins = skins, 
	assets = assets,
	tags = tags,
	
	skip_item_gen = true,
	skip_giftable_gen = true,
})