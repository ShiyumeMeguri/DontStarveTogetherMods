local assets =
{
	Asset( "ANIM", "anim/ria.zip" ),
	Asset( "ANIM", "anim/ghost_ria_build.zip" ),
}

local skins =
{
	normal_skin = "ria",
	ghost_skin = "ghost_ria_build",
}

local base_prefab = "ria"

local tags = {"RIA", "CHARACTER"}

return CreatePrefabSkin("ria_none",
{
	base_prefab = base_prefab, 
	skins = skins, 
	assets = assets,
	tags = tags,
	
	skip_item_gen = true,
	skip_giftable_gen = true,
})