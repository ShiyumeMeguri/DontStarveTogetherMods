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

PrefabFiles = {
	"yukikaze",
	"hasya_fx",
	"gyorai_fx",
	"hou_76mm",
	"sekkeizu",
}

Assets = {
	Asset( "ATLAS", "images/yukikaze.xml" ),
	Asset( "ATLAS", "images/yukikaze_skill.xml" ),
	Asset( "ATLAS", "images/yukikaze_kekon.xml" ),
	Asset( "ATLAS", "images/yukikaze_kekonshiki.xml" ),
	Asset( "ATLAS", "images/yukikaze_te.xml" ),
	
	Asset( "ANIM", "anim/koukan.zip" ),
	Asset( "ATLAS", "images/inventoryimages/yukikazetab.xml" ),
	Asset("ANIM", "anim/hou_76mm.zip"),
	Asset("ATLAS", "images/inventoryimages/hou_76mm.xml"),
	Asset("IMAGE", "images/inventoryimages/hou_76mm.tex"),
	Asset("ANIM", "anim/sekkeizu.zip"),
	Asset("ATLAS", "images/inventoryimages/sekkeizu.xml"),
	Asset("IMAGE", "images/inventoryimages/sekkeizu.tex"),
	Asset( "ANIM", "anim/hasya_fx.zip" ),
	Asset( "ANIM", "anim/gyorai_fx.zip" ),
	Asset("SOUNDPACKAGE", "sound/yukikaze.fev"),	
	Asset("SOUND", "sound/yukikaze.fsb"),  
	
	Asset( "ANIM", "anim/yukikaze.zip" ),
	Asset( "ANIM", "anim/ghost_yukikaze_build.zip" ),
	
    Asset( "IMAGE", "bigportraits/yukikaze_none.tex" ),
    Asset( "ATLAS", "bigportraits/yukikaze_none.xml" ),
	
    Asset( "IMAGE", "bigportraits/yukikaze.tex" ),
    Asset( "ATLAS", "bigportraits/yukikaze.xml" ),

    Asset( "IMAGE", "images/saveslot_portraits/yukikaze.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/yukikaze.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/yukikaze.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/yukikaze.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/yukikaze_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/yukikaze_silho.xml" ),
	
	Asset( "IMAGE", "images/map_icons/yukikaze.tex" ),
	Asset( "ATLAS", "images/map_icons/yukikaze.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_yukikaze.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_yukikaze.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_yukikaze.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_yukikaze.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_yukikaze.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_yukikaze.xml" ),
}
AddMinimapAtlas("images/map_icons/yukikaze.xml")
AddModCharacter("yukikaze", "FEMALE")

yukikazetab = AddRecipeTab("Yukikaze", 233, "images/inventoryimages/yukikazetab.xml", "yukikazetab.tex", "yukikaze_skiller")

AddRecipe("sekkeizu",
{Ingredient("papyrus", 1),Ingredient("bluegem", 1),Ingredient("gears", 2)}, 
yukikazetab, TECH.NONE,
nil, nil, nil, nil, "yukikaze_skiller",
"images/inventoryimages/sekkeizu.xml", "sekkeizu.tex")

AddRecipe("hou_76mm",
{Ingredient("sekkeizu", 10, "images/inventoryimages/sekkeizu.xml"),Ingredient("nightmarefuel", 10)}, 
yukikazetab, TECH.NONE,
nil, nil, nil, nil, "yukikaze_skiller",
"images/inventoryimages/hou_76mm.xml", "hou_76mm.tex")


if GetModConfigData("gengo") == 0 then
STRINGS.NAMES.HOU_76MM = "76mm Canon"
STRINGS.RECIPE_DESC.HOU_76MM = "Other world's things" 
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HOU_76MM = "Damage:10x1"

STRINGS.NAMES.SEKKEIZU = "Unknown design drawing"
STRINGS.RECIPE_DESC.SEKKEIZU ="Azur Lane"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SEKKEIZU = "Something is written on it"

STRINGS.CHARACTER_TITLES.yukikaze = "Yukikaze"
STRINGS.CHARACTER_NAMES.yukikaze = "Yukikaze"
STRINGS.CHARACTER_DESCRIPTIONS.yukikaze = "......"
STRINGS.CHARACTER_QUOTES.yukikaze = "\"......\""

STRINGS.NAMES.YUKIKAZE = "Yukikaze"

TUNING.YUKIKAZEIU="Exp: "
TUNING.YUKIKAZEIU1="Level: "
TUNING.YUKIKAZEIU2="You can help me if you ask so much ~"
TUNING.YUKIKAZEIU3="Do not thank you"
TUNING.YUKIKAZEIU4="You are the lowest!"
TUNING.YUKIKAZEIU5="What, is this smell!"
TUNING.YUKIKAZEIU6="Garbage!"
TUNING.YUKIKAZEIU7="Full Barrage-Yukikaze"
TUNING.YUKIKAZEIU8="Full Barrage-YukikazeⅡ"
end

if GetModConfigData("gengo") == 1 then
STRINGS.NAMES.HOU_76MM = "76mm 砲"
STRINGS.RECIPE_DESC.HOU_76MM = "ほかの世界のもの" 
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HOU_76MM = "威力:10x1" 

STRINGS.NAMES.SEKKEIZU = "知らない設計図"
STRINGS.RECIPE_DESC.SEKKEIZU = "アズールレーン"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SEKKEIZU = "なにか書いている"

STRINGS.CHARACTER_TITLES.yukikaze = "雪風"
STRINGS.CHARACTER_NAMES.yukikaze = "雪風"
STRINGS.CHARACTER_DESCRIPTIONS.yukikaze = "雪風"
STRINGS.CHARACTER_QUOTES.yukikaze = "\"なんでもないのだ！\""

STRINGS.NAMES.YUKIKAZE = "雪風"

TUNING.YUKIKAZEIU="今の経験: "
TUNING.YUKIKAZEIU1="練度: "
TUNING.YUKIKAZEIU2="そんなに頼むんなら助けてあげなくもないのだぞ～"
TUNING.YUKIKAZEIU3="感謝することをしないのだ"
TUNING.YUKIKAZEIU4="あんたは...最低のだ！"
TUNING.YUKIKAZEIU5="なにこれ、臭いのだ！"
TUNING.YUKIKAZEIU6="ごみのだ！"
TUNING.YUKIKAZEIU7="全彈發射-雪風"
TUNING.YUKIKAZEIU8="全彈發射-雪風Ⅱ"
end

local su = 0
local function koudan_hasya(inst, x, y, z)
	if inst.sg and not inst.sg:HasStateTag("busy") and not inst:HasTag("playerghost") and inst:HasTag("76mm") and inst.components.sanity.current > 10 then
		local x, y, z = ( TheInput:GetWorldPosition() or Vector3(0,0,0) ):Get()
			if su< 9 then
				su = su + 1
				else
				su = 0 inst:AddTag("hasya")
			end
			inst.components.sanity:DoDelta(-1)
				local x0,y0,z0 = inst.Transform:GetWorldPosition()
				inst.Transform:SetRotation( inst:GetAngleToPoint( x,y,z ) )
					local fx = SpawnPrefab("hasya_fx")
					fx.Transform:SetPosition( x0, 0, z0 )
					fx.Transform:SetRotation( fx:GetAngleToPoint( x,y,z ) )
					fx.master = inst
					fx.Physics:SetMotorVelOverride(35,0,0)
					
	if inst:HasTag("hasya") then
		inst.SoundEmitter:PlaySound("yukikaze/yukikazesound/sukiru")
		inst:RemoveTag("hasya")
		inst:AddTag("hasyaImage")
		if not inst:HasTag("level2") then
			inst.components.talker:Say(TUNING.YUKIKAZEIU7)
			local x0,y0,z0 = inst.Transform:GetWorldPosition()
			inst.Transform:SetRotation( inst:GetAngleToPoint( x,y,z ) )
			inst:RemoveTag("hasya")
			for k = -2, 3 do
				local fx = SpawnPrefab("hasya_fx")
				fx.Transform:SetPosition( x0, 0, z0 )
				fx.Transform:SetRotation( fx:GetAngleToPoint( x+(k/2),y,z+(k/2) ) )
				fx.master = inst
				fx.Physics:SetMotorVelOverride(35,0,0)
			end
			
			if math.random()<.2 then
					local fx = SpawnPrefab("gyorai_fx")
					fx.Transform:SetPosition( x0+1.2, 0, z0+1.2 )
					fx.Transform:SetRotation( fx:GetAngleToPoint( x+1.2,y,z+1.2 ) )
					fx.Transform:SetScale(1.5, 1.5, 1.5)
					fx.master = inst
					fx.Physics:SetMotorVelOverride(5,0,0)
					local fx = SpawnPrefab("gyorai_fx")
					fx.Transform:SetPosition( x0-1.2, 0, z0-1.2 )
					fx.Transform:SetRotation( fx:GetAngleToPoint( x-1.2,y,z-1.2 ) )
					fx.Transform:SetScale(1.5, 1.5, 1.5)
					fx.master = inst
					fx.Physics:SetMotorVelOverride(5,0,0)
					
				inst:DoTaskInTime(0.2, function()
					local fx = SpawnPrefab("gyorai_fx")
					fx.Transform:SetPosition( x0+0.7, 0, z0+0.7 )
					fx.Transform:SetRotation( fx:GetAngleToPoint( x+0.7,y,z+0.7 ) )
					fx.Transform:SetScale(1.5, 1.5, 1.5)
					fx.master = inst
					fx.Physics:SetMotorVelOverride(5,0,0)
					local fx = SpawnPrefab("gyorai_fx")
					fx.Transform:SetPosition( x0-0.7, 0, z0-0.7 )
					fx.Transform:SetRotation( fx:GetAngleToPoint( x-0.7,y,z-0.7 ) )
					fx.Transform:SetScale(1.5, 1.5, 1.5)
					fx.master = inst
					fx.Physics:SetMotorVelOverride(5,0,0)
				end)
			end
				
			inst:DoTaskInTime(0.4, function()
				for k = -2, 3 do
					local fx = SpawnPrefab("hasya_fx")
					fx.Transform:SetPosition( x0, 0, z0 )
					fx.Transform:SetRotation( fx:GetAngleToPoint( x+(k/2),y,z+(k/2) ) )
					fx.master = inst
					fx.Physics:SetMotorVelOverride(35,0,0)
				end
			end)

							else
			inst.SoundEmitter:PlaySound("yukikaze/yukikazesound/sukiru")
			inst.components.talker:Say(TUNING.YUKIKAZEIU8)
			local x0,y0,z0 = inst.Transform:GetWorldPosition()
			inst.Transform:SetRotation( inst:GetAngleToPoint( x,y,z ) )
			inst:RemoveTag("hasya")
			for k = -2, 3 do
				local fx = SpawnPrefab("hasya_fx")
				fx.Transform:SetPosition( x0, 0, z0 )
				fx.Transform:SetRotation( fx:GetAngleToPoint( x+(k/2),y,z+(k/2) ) )
				fx.master = inst
				fx.Physics:SetMotorVelOverride(35,0,0)
			end
			
			if math.random()<.3 then
					local fx = SpawnPrefab("gyorai_fx")
					fx.Transform:SetPosition( x0+1.2, 0, z0+1.2 )
					fx.Transform:SetRotation( fx:GetAngleToPoint( x+1.2,y,z+1.2 ) )
					fx.Transform:SetScale(1.5, 1.5, 1.5)
					fx.master = inst
					fx.Physics:SetMotorVelOverride(5,0,0)
					local fx = SpawnPrefab("gyorai_fx")
					fx.Transform:SetPosition( x0-1.2, 0, z0-1.2 )
					fx.Transform:SetRotation( fx:GetAngleToPoint( x-1.2,y,z-1.2 ) )
					fx.Transform:SetScale(1.5, 1.5, 1.5)
					fx.master = inst
					fx.Physics:SetMotorVelOverride(5,0,0)
					
				inst:DoTaskInTime(0.2, function()
					local fx = SpawnPrefab("gyorai_fx")
					fx.Transform:SetPosition( x0+0.7, 0, z0+0.7 )
					fx.Transform:SetRotation( fx:GetAngleToPoint( x+0.7,y,z+0.7 ) )
					fx.Transform:SetScale(1.5, 1.5, 1.5)
					fx.master = inst
					fx.Physics:SetMotorVelOverride(5,0,0)
					local fx = SpawnPrefab("gyorai_fx")
					fx.Transform:SetPosition( x0-0.7, 0, z0-0.7 )
					fx.Transform:SetRotation( fx:GetAngleToPoint( x-0.7,y,z-0.7 ) )
					fx.Transform:SetScale(1.5, 1.5, 1.5)
					fx.master = inst
					fx.Physics:SetMotorVelOverride(5,0,0)
				end)
			end
			
			inst:DoTaskInTime(0.4, function()
				for k = -2, 3 do
					local fx = SpawnPrefab("hasya_fx")
					fx.Transform:SetPosition( x0, 0, z0 )
					fx.Transform:SetRotation( fx:GetAngleToPoint( x+(k/2),y,z+(k/2) ) )
					fx.master = inst
					fx.Physics:SetMotorVelOverride(35,0,0)
				end
				
				inst:DoTaskInTime(0.4, function()
					for k = -2, 3 do
						local fx = SpawnPrefab("hasya_fx")
						fx.Transform:SetPosition( x0, 0, z0 )
						fx.Transform:SetRotation( fx:GetAngleToPoint( x+(k/2),y,z+(k/2) ) )
						fx.master = inst
						fx.Physics:SetMotorVelOverride(35,0,0)
					end
				end)
			end)
		end
	end
	end
end

function SetNetvar(inst,nettab)
	local t = {
		net_shortint		=		net_shortint,
		net_tinybyte		=		net_tinybyte,
		net_smallbyte		=		net_smallbyte,
		net_byte			=		net_byte,
		net_shortint		=		net_shortint,
		net_ushortint		=		net_ushortint,
		net_int				=		net_int,
		net_uint			=		net_uint,
		net_float			=		net_float,
		net_hash			=		net_hash,
		net_string			=		net_string,
		net_entity			=		net_entity,
		net_bytearray		=		net_bytearray,
		net_smallbytearray	=		net_smallbytearray,
	}
	for k,v in pairs(nettab) do
		if type(v) == "table" then
			inst[k] = t[v[1]](inst.GUID, k, k.."dirty")
			inst[k]:set(v[2])
		end
	end
end

TUNING.HANASI=0
TUNING.REBERU_UPEXP=100
TUNING.REBERU_EXP=0
TUNING.MOVEIMAGE=-1000
TUNING.MOVEIMAGE1=150
TUNING.ONKEKON=0
AddPlayerPostInit(function(inst)
	if inst.prefab == "yukikaze" then
		SetNetvar(inst,{
			koukan_max = {"net_shortint", 100},
			koukan_current = {"net_shortint", 0},
		})
		if TheWorld.ismastersim then
			inst:AddComponent("koukan")
			inst:DoPeriodicTask(0, function()
				if inst:HasTag("hasyaImage") then
						TUNING.MOVEIMAGE = TUNING.MOVEIMAGE + 8
					if TUNING.MOVEIMAGE>-640 then
						TUNING.MOVEIMAGE = -640
						inst:DoTaskInTime(1, function()inst:RemoveTag("hasyaImage")TUNING.MOVEIMAGE = -1000 end)
					end
				end
				
				if inst:HasTag("kekonsuru") then
					TUNING.MOVEIMAGE1=TUNING.MOVEIMAGE1-1
					if TUNING.MOVEIMAGE1<=0 then
						TUNING.MOVEIMAGE1 = 0
					end
				end
				
				if not inst:HasTag("kekonsuru") then
					TUNING.MOVEIMAGE1=TUNING.MOVEIMAGE1+1
					if TUNING.MOVEIMAGE1>=150 then
						TUNING.MOVEIMAGE1 = 150
					end
				end
				
				if TUNING.ONKEKONTE then
					TUNING.KEKONTE=TUNING.KEKONTE-1
					if TUNING.KEKONTE < 400 then
						TUNING.KEKONTE = 400
					end
				end
			end)
			inst:DoPeriodicTask(2, function()koudan_hasya(inst) end)
			
		end
	end
end)

local yukikaze_skill = require("widgets/yukikaze_skill")
local koukan = require("widgets/koukan")
local kekon = require("widgets/kekon")

local function Addkekon(self) 
	if self.owner and self.owner:HasTag("yukikaze_skiller") then
		self.kekon = self.status:AddChild(kekon(self.owner))
	end
end

AddClassPostConstruct("widgets/controls", Addkekon)

local function Addkoukan(self) 
	if self.owner and self.owner:HasTag("yukikaze_skiller") then
		self.koukan = self.status:AddChild(koukan(self.owner))
		self.koukan:SetPosition(0,-400,0)		
	end
end

AddClassPostConstruct("widgets/controls", Addkoukan)

TUNING.KEKONTE = 900
TUNING.YOMEYUKIKAZE = 0
local function AddYukikaze_skill(self)
	if self.owner and self.owner:HasTag("yukikaze_skiller") then	
		self.yukikaze_skill = self.bottom_root:AddChild( yukikaze_skill("images/yukikaze_skill.xml", "yukikaze_skill.tex", TUNING.MOVEIMAGE,40,0) )		
		self.yukikaze_kekonshiki = self.bottom_root:AddChild( yukikaze_skill("images/yukikaze_kekonshiki.xml", "yukikaze_kekonshiki.tex", -1920,-1920,0) )		
		self.yukikaze_te = self.bottom_root:AddChild( yukikaze_skill("images/yukikaze_te.xml", "yukikaze_te.tex", -1920,-1920,0) )			
		self.yukikazeimg = self.bottom_root:AddChild( yukikaze_skill("images/yukikaze.xml", "yukikaze.tex", -1920,-1920,0) )	
local old_OnUpdate = self.OnUpdate
		self.OnUpdate = function(self, dt)
			old_OnUpdate(self, dt)
			self.yukikaze_skill:SetPosition(TUNING.MOVEIMAGE,40,0)
			
			self.yukikazeimg:SetPosition(0,450,0)
			self.yukikazeimg:SetTint(TUNING.YOMEYUKIKAZE,TUNING.YOMEYUKIKAZE,TUNING.YOMEYUKIKAZE,TUNING.YOMEYUKIKAZE)
			
			if TUNING.KEKONSHOW == 1 then
			self.yukikaze_kekonshiki:SetPosition(0,450,0)
			if TUNING.YOMEYUKIKAZE < 1 then
			TUNING.YOMEYUKIKAZE = TUNING.YOMEYUKIKAZE + .007
			end
			
			
			ThePlayer:DoTaskInTime(5, function() TUNING.YOMEYUKIKAZE = 0 
			TUNING.ONKEKONTE = 1 end)
			if TUNING.ONKEKONTE == 1 then
			self.yukikaze_te:SetPosition(0,TUNING.KEKONTE,0)
			end
				
				ThePlayer:DoTaskInTime(15, function()TUNING.KEKONSHOW = 0 end)
			else 
			self.yukikaze_kekonshiki:SetPosition(-1920,-1920,0)
			self.yukikaze_te:SetPosition(-1920,-1920,0)
			self.yukikazeimg:SetPosition(-1920,-1920,0)
			end
		end
	end
end

AddClassPostConstruct("widgets/controls", AddYukikaze_skill)


STRINGS.CHARACTERS.YUKIKAZE = require "speech_willow"