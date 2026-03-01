return require "prefabs/player_common"("tina", {}, 
{
	Asset( "ANIM", "anim/bullet.zip"),
	Asset( "ANIM", "anim/bullet_fx.zip"),
	Asset( "ANIM", "anim/teisatuwana.zip"),
	Asset( "ANIM", "anim/maryoku.zip"),

	Asset( "ANIM", "anim/ax338.zip"),
	Asset( "ANIM", "anim/swap_ax338.zip" ),
	Asset( "ANIM", "anim/ax338_dansou.zip" ),
	Asset( "ATLAS", "images/inventoryimages/ax338.xml"),
	Asset( "ATLAS", "images/inventoryimages/ax338_dansou.xml"),
	
	Asset( "ANIM", "anim/tina.zip" ),
	Asset( "ANIM", "anim/tina_night.zip" ),
	Asset( "ANIM", "anim/ghost_tina_build.zip" ),
	
	Asset( "IMAGE", "images/saveslot_portraits/tina.tex" ),
	Asset( "ATLAS", "images/saveslot_portraits/tina.xml" ),

	Asset( "IMAGE", "bigportraits/tina.tex" ),
	Asset( "ATLAS", "bigportraits/tina.xml" ),
	
	Asset( "IMAGE", "images/map_icons/tina.tex" ),
	Asset( "ATLAS", "images/map_icons/tina.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_tina.tex" ),
	Asset( "ATLAS", "images/avatars/avatar_tina.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_tina.tex" ),
	Asset( "ATLAS", "images/avatars/avatar_ghost_tina.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_tina.tex" ),
	Asset( "ATLAS", "images/avatars/self_inspect_tina.xml" ),
	
	Asset( "IMAGE", "images/names_tina.tex" ),
	Asset( "ATLAS", "images/names_tina.xml" ),
	
	Asset( "IMAGE", "images/names_gold_tina.tex" ),
	Asset( "ATLAS", "images/names_gold_tina.xml" ),
	
	Asset( "SOUNDPACKAGE", "sound/tina.fev" ),
	Asset( "SOUND", "sound/tina.fsb" ),
}, 
function(inst) --サーバーの初期化
if TUNING.Tina_G.TheSim.RAILGetPlatform and TUNING.Tina_G.TheSim:RAILGetPlatform() == "TGP" then return end
if TUNING.Tina_Init == false then
	TUNING.AX338 = TUNING.Tina_G.GetModConfigData("AX338")
	TUNING.KUROIKAZE = TUNING.Tina_G.GetModConfigData("KUROIKAZE")
	TUNING.TEISATUWANA = TUNING.Tina_G.GetModConfigData("TEISATUWANA")
	TUNING.INFO = TUNING.Tina_G.GetModConfigData("INFO")
	
	TUNING.Tina_G.AddPlayerPostInit(function(inst)
		 local function SetNetvar(inst,nettab)
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
if inst.prefab == "tina" then
	SetNetvar(inst,{
	 maryoku_max = {"net_shortint", 310},
	 maryoku_current = {"net_shortint", 310},
	 })
end
if TheWorld.ismastersim and inst.prefab == "tina" and not inst.components.maryoku then
	inst:AddComponent("maryoku")
end
end)
	local maryokubadge = require("widgets/maryokubadge")
	TUNING.Tina_G.AddClassPostConstruct("widgets/controls", function(self) 
		 if self.owner and self.owner:HasTag("tina_build") then
			self.maryokubadge = self.status:AddChild(maryokubadge(self.owner))
			self.maryokubadge:SetPosition(0,-350,0)		
		end
		end)
		TUNING.Tina_Init = true
end
--レベル
inst.Tina_Level = function(inst)
local LV = math.min(inst.level, 18)

	inst.components.health.maxhealth =	54.5	+ LV * 9.91	--Max 233
	inst.components.hunger.max =		100 	+ LV * 3	--Max 154
	inst.components.sanity.max =		120 	+ LV * 3	--Max 174
	inst.components.maryoku.maxtimepiont =		310 	+ LV * 10	--Max 490
	
	if LV >= 6 then 
		inst.components.locomotor:SetExternalSpeedMultiplier(inst, "owl_skill", 1.09) 
		inst.components.health.absorb = .3
	end
	
	inst.components.health:SetPercent(inst.components.health:GetPercent())
	inst.components.hunger:SetPercent(inst.components.hunger:GetPercent())
	inst.components.sanity:SetPercent(inst.components.sanity:GetPercent())
end
--Vスキル
TUNING.Tina_G.AddModRPCHandler("tina", "AX338", function(inst)
	if not inst:HasTag("ax338") or inst:HasTag("ax338_Finished") or inst:HasTag("AX338CD") or inst.components.maryoku.currenttimepiont <= 40 + ( inst.level * 2) then return end
	inst:AddTag("AX338CD")
	
	inst.ax338.components.finiteuses:Use(1)
	inst.components.maryoku:DoDelta(-40)
	local x0,y0,z0 = inst.Transform:GetWorldPosition()
	inst.components.playercontroller:Enable(false)
	inst.AnimState:PlayAnimation("ax338")
	
	local fx = SpawnPrefab("bullet_fx")
	fx.owner = inst
	
	local pos = math.ceil(inst.Transform:GetRotation()/90)
		if pos == 1 then						--左1 右-1 下0 上2
			fx.Transform:SetPosition( x0-1, 0, z0-1 )
			elseif pos == -1 then 
			 fx.Transform:SetPosition( x0-1, 0, z0-1 )
			 elseif pos == 2 then 
				 fx.Transform:SetPosition( x0+.2, 0, z0+.3 )
				 elseif pos == 0 then 
					 fx.Transform:SetPosition( x0-.2, 0, z0-.3 )
				 end
				 
				 fx.Transform:SetRotation( inst.Transform:GetRotation() )
				 fx.master = inst
				 fx.Physics:SetMotorVelOverride(20,0,0)
				 inst:DoTaskInTime(.7, function()
					inst.components.playercontroller:Enable(true)
					end )
				 
				 inst:DoTaskInTime(4, function()
					inst:RemoveTag("AX338CD")
					end )
				 end)	
--Rスキル
TUNING.Tina_G.AddModRPCHandler("tina", "KUROIKAZE", function(inst)
	if inst:HasTag("KuroiKazeCD") or inst:HasTag("playerghost") or inst.components.maryoku.currenttimepiont <= 40 then return end
	inst:AddTag("KuroiKazeCD")
	inst.components.maryoku:DoDelta(-40)
	inst.AX338BUFF = 200 + (inst.level * 7) + math.random() * 100
	inst:AddTag("KuroiKazeBuff")
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "KuroiKaze", 4)
	inst:DoTaskInTime(.1, function()
		 inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "KuroiKaze")
		 end )
	
	inst:DoTaskInTime(6, function()
		inst:RemoveTag("KuroiKazeCD")
		end )
	end)
--Cスキル
TUNING.Tina_G.AddModRPCHandler("tina", "TEISATUWANA", function(inst)
	if inst:HasTag("TeisatuWanaCD") or inst:HasTag("playerghost") or inst.components.maryoku.currenttimepiont <= 40 + ( inst.level * 2) then return end
	
	local x,y,z = inst.Transform:GetWorldPosition()
	for k, v in pairs(TheSim:FindEntities(x,y,z,1)) do
		if v:HasTag("wana") then return end
	end

	inst:AddTag("TeisatuWanaCD")
	inst.components.maryoku:DoDelta(-40)
	local wana = SpawnPrefab("teisatuwana")
	if wana ~= nil then
		wana.owner = inst
		wana.Transform:SetPosition(inst.Transform:GetWorldPosition())
	end
	
	inst:DoTaskInTime(10, function()
		inst:RemoveTag("TeisatuWanaCD")
		end )
	end)
--Zスキル
TUNING.Tina_G.AddModRPCHandler("tina", "INFO", function(inst)
	if inst:HasTag("ax338_Finished") then inst.AX338BUFF = 20 end
	inst.components.talker:Say(
"LV:".. (inst.level)..[[
]].."EXP:"..(inst.exp)..[[
]].."AX338Damage:"..(inst.AX338BUFF)..[[
]])
	end)
	
--AX338のアタックアクションの追加
TUNING.Tina_G.AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.ATTACK, 
	function(inst, action)
        inst.sg.mem.localchainattack = not action.forced or nil
        if not (inst.sg:HasStateTag("attack") and action.target == inst.sg.statemem.attacktarget or inst.components.health:IsDead()) then
            local weapon = inst.components.combat ~= nil and inst.components.combat:GetWeapon() or nil
            return (weapon == nil and "attack")
            or (weapon:HasTag("blowdart") and "blowdart")
            or (weapon:HasTag("thrown") and "throw")
            or (weapon:HasTag("multithruster") and "multithrust_pre")
            or ((weapon:HasTag("ax338") and not weapon:HasTag("ax338_Finished") ) and "ax338")
            or "attack"
        end
        end))
TUNING.Tina_G.AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.ATTACK,
    function(inst, action)
        if not (inst.sg:HasStateTag("attack") and action.target == inst.sg.statemem.attacktarget or inst.replica.health:IsDead()) then
            local equip = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            if equip == nil then
                return "attack"
            end
            local inventoryitem = equip.replica.inventoryitem
            return (not (inventoryitem ~= nil and inventoryitem:IsWeapon()) and "attack")
            or (equip:HasTag("blowdart") and "blowdart")
            or (equip:HasTag("thrown") and "throw")
            or ((equip:HasTag("ax338") and  not equip:HasTag("ax338_Finished") ) and "ax338")
            or "attack"
        end
        end))
--ティナちゃんの眠り時間の変更
TUNING.Tina_G.AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.SLEEPIN, 
	function(inst, action)
		if action.invobject ~= nil then
			if action.invobject.onuse ~= nil then
				action.invobject:onuse(inst)
			end
          if inst.prefab ~= "tina" then
             return "bedroll"
         else 
             return "bedroll_tina"
         end
         elseif inst.prefab ~= "tina" then
             return "tent"
         else
             return "tent_tina"
         end
         end))
TUNING.Tina_G.AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.SLEEPIN,
    function(inst, action)
      if action.invobject ~= nil then
         if action.invobject.onuse ~= nil then
            action.invobject:onuse(inst)
        end
        if inst.prefab ~= "tina" then
         return "bedroll"
     else 
         return "bedroll_tina"
     end
     elseif inst.prefab ~= "tina" then
         return "tent"
     else
         return "tent_tina"
     end
     end))
--AX338のアタックアクション
local AX338_Action = State{
name = "ax338",
tags = { "attack", "notalking", "abouttoattack", "autopredict" },

onenter = function(inst)
inst.ax338sound = "tina/tina_buki/Attack_Fire_0"..( math.ceil( math.random()*3 ))
local buffaction = inst:GetBufferedAction()
local target = buffaction ~= nil and buffaction.target or nil
local equip = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
inst.components.combat:SetTarget(target)
inst.components.combat:StartAttack()
inst.components.locomotor:Stop()
inst.AnimState:PlayAnimation("ax338_pre")
if inst.sg.prevstate == inst.sg.currentstate then
    inst.sg.statemem.chained = true
    inst.AnimState:SetTime(5 * TUNING.Tina_G.FRAMES)
end
inst.AnimState:PushAnimation("ax338", false)

inst.sg:SetTimeout(math.max((inst.sg.statemem.chained and 14 or 18) * TUNING.Tina_G.FRAMES, 12 + .5 * TUNING.Tina_G.FRAMES))

if target ~= nil and target:IsValid() then
    inst:FacePoint(target.Transform:GetWorldPosition())
    inst.sg.statemem.attacktarget = target
end

if (equip ~= nil and equip.projectiledelay or 0) > 0 then
    inst.sg.statemem.projectiledelay = (inst.sg.statemem.chained and 9 or 14) * TUNING.Tina_G.FRAMES - equip.projectiledelay
    if inst.sg.statemem.projectiledelay <= 0 then
        inst.sg.statemem.projectiledelay = nil
    end
end
end,

onupdate = function(inst, dt)
if (inst.sg.statemem.projectiledelay or 0) > 0 then
    inst.sg.statemem.projectiledelay = inst.sg.statemem.projectiledelay - dt
    if inst.sg.statemem.projectiledelay <= 0 then
        inst:PerformBufferedAction()
        inst.sg:RemoveStateTag("abouttoattack")
    end
end
end,

timeline =
{
    TimeEvent(8 * TUNING.Tina_G.FRAMES, function(inst)
        if inst.sg.statemem.chained then
            inst.SoundEmitter:PlaySound(inst.ax338sound, nil, nil, true)
        end
        end),
    TimeEvent(9 * TUNING.Tina_G.FRAMES, function(inst)
        if inst.sg.statemem.chained and inst.sg.statemem.projectiledelay == nil then
            inst:PerformBufferedAction()
            inst.sg:RemoveStateTag("abouttoattack")
        end
        end),
    TimeEvent(13 * TUNING.Tina_G.FRAMES, function(inst)
        if not inst.sg.statemem.chained then
            inst.SoundEmitter:PlaySound(inst.ax338sound, nil, nil, true)
        end
        end),
    TimeEvent(14 * TUNING.Tina_G.FRAMES, function(inst)
        if not inst.sg.statemem.chained and inst.sg.statemem.projectiledelay == nil then
            inst:PerformBufferedAction()
            inst.sg:RemoveStateTag("abouttoattack")
        end
        end),
    },

    ontimeout = function(inst)
    inst.sg:RemoveStateTag("attack")
    inst.sg:AddStateTag("idle")
    end,

    events =
    {
    EventHandler("equip", function(inst) inst.sg:GoToState("idle") end),
    EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
    EventHandler("animqueueover", function(inst)
        if inst.AnimState:AnimDone() then
            inst.sg:GoToState("idle")
        end
        end),
    },

    onexit = function(inst)
    inst.components.combat:SetTarget(nil)
    if inst.sg:HasStateTag("abouttoattack") then
        inst.components.combat:CancelAttack()
    end
    end,
}
local AX338_Action_Client = State{
name = "ax338",
tags = { "attack", "notalking", "abouttoattack" },

onenter = function(inst)
inst.ax338sound = "tina/tina_buki/Attack_Fire_0"..( math.ceil( math.random()*3 ))
local equip = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
inst.components.locomotor:Stop()

inst.AnimState:PlayAnimation("ax338_pre")
if inst.sg.prevstate == inst.sg.currentstate then
    inst.sg.statemem.chained = true
    inst.AnimState:SetTime(5 * TUNING.Tina_G.FRAMES)
end
inst.AnimState:PushAnimation("ax338", false)

if inst.replica.combat ~= nil then
    inst.replica.combat:StartAttack()
    inst.sg:SetTimeout(math.max((inst.sg.statemem.chained and 14 or 18) * TUNING.Tina_G.FRAMES, 12 + .5 * TUNING.Tina_G.FRAMES))
end

local buffaction = inst:GetBufferedAction()
if buffaction ~= nil then
    inst:PerformPreviewBufferedAction()

    if buffaction.target ~= nil and buffaction.target:IsValid() then
        inst:FacePoint(buffaction.target:GetPosition())
        inst.sg.statemem.attacktarget = buffaction.target
    end
end

if (equip.projectiledelay or 0) > 0 then
    inst.sg.statemem.projectiledelay = (inst.sg.statemem.chained and 9 or 14) * TUNING.Tina_G.FRAMES - equip.projectiledelay
    if inst.sg.statemem.projectiledelay <= 0 then
        inst.sg.statemem.projectiledelay = nil
    end
end
end,

onupdate = function(inst, dt)
if (inst.sg.statemem.projectiledelay or 0) > 0 then
    inst.sg.statemem.projectiledelay = inst.sg.statemem.projectiledelay - dt
    if inst.sg.statemem.projectiledelay <= 0 then
        inst:ClearBufferedAction()
        inst.sg:RemoveStateTag("abouttoattack")
    end
end
end,

timeline =
{
    TimeEvent(8 * TUNING.Tina_G.FRAMES, function(inst)
        if inst.sg.statemem.chained then
            inst.SoundEmitter:PlaySound(inst.ax338sound, nil, nil, true)
        end
        end),
    TimeEvent(9 * TUNING.Tina_G.FRAMES, function(inst)
        if inst.sg.statemem.chained and inst.sg.statemem.projectiledelay == nil then
            inst:ClearBufferedAction()
            inst.sg:RemoveStateTag("abouttoattack")
        end
        end),
    TimeEvent(13 * TUNING.Tina_G.FRAMES, function(inst)
        if not inst.sg.statemem.chained then
            inst.SoundEmitter:PlaySound(inst.ax338sound, nil, nil, true)
        end
        end),
    TimeEvent(14 * TUNING.Tina_G.FRAMES, function(inst)
        if not inst.sg.statemem.chained and inst.sg.statemem.projectiledelay == nil then
            inst:ClearBufferedAction()
            inst.sg:RemoveStateTag("abouttoattack")
        end
        end),
    },

    ontimeout = function(inst)
    inst.sg:RemoveStateTag("attack")
    inst.sg:AddStateTag("idle")
    end,

    events =
    {
    EventHandler("animqueueover", function(inst)
        if inst.AnimState:AnimDone() then
            inst.sg:GoToState("idle")
        end
        end),
    },

    onexit = function(inst)
    if inst.sg:HasStateTag("abouttoattack") and inst.replica.combat ~= nil then
        inst.replica.combat:CancelAttack()
    end
    end,
}
TUNING.Tina_G.AddStategraphState("wilson", AX338_Action)
TUNING.Tina_G.AddStategraphState("wilson_client", AX338_Action_Client)
--ティナちゃんの眠り状態
local function SetSleeperAwakeState(inst)
	if inst.components.grue ~= nil then
		inst.components.grue:RemoveImmunity("sleeping")
	end
	if inst.components.talker ~= nil then
		inst.components.talker:StopIgnoringAll("sleeping")
	end
	if inst.components.firebug ~= nil then
		inst.components.firebug:Enable()
	end
	if inst.components.playercontroller ~= nil then
		inst.components.playercontroller:EnableMapControls(true)
		inst.components.playercontroller:Enable(true)
	end
	inst:OnWakeUp()
	inst.components.inventory:Show()
	inst:ShowActions(true)
end
local function SetSleeperSleepState(inst)
	if inst.components.grue ~= nil then
		inst.components.grue:AddImmunity("sleeping")
	end
	if inst.components.talker ~= nil then
		inst.components.talker:IgnoreAll("sleeping")
	end
	if inst.components.firebug ~= nil then
		inst.components.firebug:Disable()
	end
	if inst.components.playercontroller ~= nil then
		inst.components.playercontroller:EnableMapControls(false)
		inst.components.playercontroller:Enable(false)
	end
	inst:OnSleepIn()
	inst.components.inventory:Hide()
	inst:PushEvent("ms_closepopups")
	inst:ShowActions(false)
end
local function IsNearDanger(inst)
	local hounded = TheWorld.components.hounded
	if hounded ~= nil and (hounded:GetWarning() or hounded:GetAttacking()) then
		return true
	end
	local burnable = inst.components.burnable
	if burnable ~= nil and (burnable:IsBurning() or burnable:IsSmoldering()) then
		return true
	end
	if inst:HasTag("spiderwhisperer") then
		return FindEntity(inst, 10,
			function(target)
				return (target.components.combat ~= nil and target.components.combat.target == inst)
               or ((target:HasTag("monster") or target:HasTag("pig")) and
                  not (target:HasTag("player") or target:HasTag("spider")) and
                  not (inst.components.sanity:IsSane() and target:HasTag("shadowcreature")))
               end,
               nil, nil, { "monster", "pig", "_combat" }) ~= nil
	end
	return FindEntity(inst, 10,
		function(target)
			return (target.components.combat ~= nil and target.components.combat.target == inst)
            or (target:HasTag("monster") and
               not target:HasTag("player") and
               not (inst.components.sanity:IsSane() and target:HasTag("shadowcreature")))
            end,
            nil, nil, { "monster", "_combat" }) ~= nil
end
local Tina_Tent = State{
name = "tent_tina",
tags = { "tent_tina", "tent", "busy", "silentmorph" },

onenter = function(inst)

inst.components.locomotor:Stop()

local target = inst:GetBufferedAction().target
local siesta = target:HasTag("siestahut")
local failreason =
(siesta ~= not TheWorld.state.isday and
    (siesta
        and (TheWorld:HasTag("cave") and "ANNOUNCE_NODAYSLEEP_CAVE" or "ANNOUNCE_NODAYSLEEP_CAVE")
        or (TheWorld:HasTag("cave") and "ANNOUNCE_NODAYSLEEP_CAVE" or "ANNOUNCE_NODAYSLEEP_CAVE"))
    )
or (target.components.burnable ~= nil and
    target.components.burnable:IsBurning() and
    "ANNOUNCE_NOSLEEPONFIRE")
or (IsNearDanger(inst) and "ANNOUNCE_NODANGERSLEEP")
or (inst.components.hunger.current < TUNING.CALORIES_MED and "ANNOUNCE_NOHUNGERSLEEP")
or (inst.components.beaverness ~= nil and inst.components.beaverness:IsStarving() and "ANNOUNCE_NOHUNGERSLEEP")
or nil

if failreason ~= nil then
    inst:PushEvent("performaction", { action = inst.bufferedaction })
    inst:ClearBufferedAction()
    inst.sg:GoToState("idle")
    if inst.components.talker ~= nil then
        inst.components.talker:Say(GetString(inst, failreason))
    end
    return
end

inst.AnimState:PlayAnimation("pickup")
inst.sg:SetTimeout(6 * TUNING.Tina_G.FRAMES)

SetSleeperSleepState(inst)
end,

ontimeout = function(inst)
local bufferedaction = inst:GetBufferedAction()
if bufferedaction == nil then
    inst.AnimState:PlayAnimation("pickup_pst")
    inst.sg:GoToState("idle", true)
    return
end
local tent = bufferedaction.target
if tent == nil or
    not tent:HasTag("tent") or
    tent:HasTag("hassleeper") or
    tent:HasTag("siestahut") ~= not TheWorld.state.isday or
    (tent.components.burnable ~= nil and tent.components.burnable:IsBurning()) then
    inst:PushEvent("performaction", { action = inst.bufferedaction })
    inst:ClearBufferedAction()
    inst.AnimState:PlayAnimation("pickup_pst")
    inst.sg:GoToState("idle", true)
else
    inst:PerformBufferedAction()
    inst.components.health:SetInvincible(true)
    inst:Hide()
    if inst.Physics ~= nil then
        inst.Physics:Teleport(inst.Transform:GetWorldPosition())
    end
    if inst.DynamicShadow ~= nil then
        inst.DynamicShadow:Enable(false)
    end
    inst.sg:AddStateTag("sleeping")
    inst.sg:RemoveStateTag("busy")
    if inst.components.playercontroller ~= nil then
        inst.components.playercontroller:Enable(true)
    end
end
end,

onexit = function(inst)

inst.components.health:SetInvincible(false)
inst:Show()
if inst.DynamicShadow ~= nil then
    inst.DynamicShadow:Enable(true)
end
if inst.sleepingbag ~= nil then
    inst.sleepingbag.components.sleepingbag:DoWakeUp(true)
    inst.sleepingbag = nil
    SetSleeperAwakeState(inst)
    elseif not inst.sg.statemem.iswaking then
        SetSleeperAwakeState(inst)
    end
    end,
}
local Tina_Tent_Client = State{
name = "tent_tina",
tags = { "tent_tina", "tent", "busy" },

onenter = function(inst)
inst.components.locomotor:Stop()
inst.AnimState:PlayAnimation("pickup")
inst.AnimState:PushAnimation("pickup_lag", false)

inst:PerformPreviewBufferedAction()
inst.sg:SetTimeout(TUNING.Tina_G.TIMEOUT)
end,

onupdate = function(inst)
if inst:HasTag("busy") or inst:HasTag("sleeping") then
    if inst.entity:FlattenMovementPrediction() then
        inst.sg:GoToState("idle", "noanim")
    end
    elseif inst.bufferedaction == nil then
        inst.AnimState:PlayAnimation("pickup_pst")
        inst.sg:GoToState("idle", true)
    end
    end,

    ontimeout = function(inst)
    inst:ClearBufferedAction()
    inst.AnimState:PlayAnimation("pickup_pst")
    inst.sg:GoToState("idle", true)
    end,
}
local Tina_Bedroll = State{
name = "bedroll_tina",
tags = { "bedroll_tina", "bedroll", "busy", "nomorph" },

onenter = function(inst)
inst.components.locomotor:Stop()

local failreason =
(not TheWorld.state.isday and
    (TheWorld:HasTag("cave") and "ANNOUNCE_NODAYSLEEP_CAVE" or "ANNOUNCE_NODAYSLEEP_CAVE")
    )
or (IsNearDanger(inst) and "ANNOUNCE_NODANGERSLEEP")
or (inst.components.hunger.current < TUNING.CALORIES_MED and "ANNOUNCE_NOHUNGERSLEEP")
or (inst.components.beaverness ~= nil and inst.components.beaverness:IsStarving() and "ANNOUNCE_NOHUNGERSLEEP")
or nil

if failreason ~= nil then
    inst:PushEvent("performaction", { action = inst.bufferedaction })
    inst:ClearBufferedAction()
    inst.sg:GoToState("idle")
    if inst.components.talker ~= nil then
        inst.components.talker:Say(GetString(inst, failreason))
    end
    return
end

inst.AnimState:PlayAnimation("action_uniqueitem_pre")
inst.AnimState:PushAnimation("bedroll", false)

SetSleeperSleepState(inst)
end,

timeline =
{
    TimeEvent(20 * TUNING.Tina_G.FRAMES, function(inst)
        inst.SoundEmitter:PlaySound("dontstarve/wilson/use_bedroll")
        end),
    },

    events =
    {
    EventHandler("firedamage", function(inst)
        if inst.sg:HasStateTag("sleeping") then
            inst.sg.statemem.iswaking = true
            inst.sg:GoToState("wakeup")
        end
        end),
    EventHandler("animqueueover", function(inst)
        if inst.AnimState:AnimDone() then
            if not TheWorld.state.isday or
                (inst.components.health ~= nil and inst.components.health.takingfiredamage) or
                (inst.components.burnable ~= nil and inst.components.burnable:IsBurning()) then
                inst:PushEvent("performaction", { action = inst.bufferedaction })
                inst:ClearBufferedAction()
                inst.sg.statemem.iswaking = true
                inst.sg:GoToState("wakeup")
                elseif inst:GetBufferedAction() then
                    inst:PerformBufferedAction()
                    if inst.components.playercontroller ~= nil then
                        inst.components.playercontroller:Enable(true)
                    end
                    inst.sg:AddStateTag("sleeping")
                    inst.sg:AddStateTag("silentmorph")
                    inst.sg:RemoveStateTag("nomorph")
                    inst.sg:RemoveStateTag("busy")
                    inst.AnimState:PlayAnimation("bedroll_sleep_loop", true)
                else
                    inst.sg.statemem.iswaking = true
                    inst.sg:GoToState("wakeup")
                end
            end
            end),
    },

    onexit = function(inst)
    if inst.sleepingbag ~= nil then
        inst.sleepingbag.components.sleepingbag:DoWakeUp(true)
        inst.sleepingbag = nil
        SetSleeperAwakeState(inst)
        elseif not inst.sg.statemem.iswaking then
            SetSleeperAwakeState(inst)
        end
        end,
    }
    local Tina_Bedroll_Client = State
    {
    name = "bedroll_tina",
    tags = { "bedroll_tina","bedroll", "busy" },

    onenter = function(inst)
    inst.components.locomotor:Stop()
    inst.AnimState:PlayAnimation("action_uniqueitem_pre")
    inst.AnimState:PushAnimation("action_uniqueitem_lag", false)

    inst:PerformPreviewBufferedAction()
    inst.sg:SetTimeout(TUNING.Tina_G.TIMEOUT)
    end,

    onupdate = function(inst)
    if inst:HasTag("busy") or inst:HasTag("sleeping") then
        if inst.entity:FlattenMovementPrediction() then
            inst.sg:GoToState("idle", "noanim")
        end
        elseif inst.bufferedaction == nil then
            inst.sg:GoToState("idle")
        end
        end,

        ontimeout = function(inst)
        inst:ClearBufferedAction()
        inst.sg:GoToState("idle")
        end,
    }
    TUNING.Tina_G.AddStategraphState("wilson", Tina_Tent)
    TUNING.Tina_G.AddStategraphState("wilson_client", Tina_Tent_Client)
    TUNING.Tina_G.AddStategraphState("wilson", Tina_Bedroll)
    TUNING.Tina_G.AddStategraphState("wilson_client", Tina_Bedroll_Client)
--フレンドリー
TUNING.Tina_G.AddStategraphPostInit("bird", function(sg)
	local old = sg.events.flyaway.fn
	local function RecheckForThreat(inst)
		local busy = inst.sg:HasStateTag("sleeping") or inst.sg:HasStateTag("busy") or inst.sg:HasStateTag("flying")
		if not busy then
			local threat = FindEntity(inst, 5, nil, nil, {'notarget', 'tina_build'}, {'player'})
			return threat ~= nil or TheWorld.state.isnight
		end
	end
	sg.events.flyaway.fn = function(inst)
  if RecheckForThreat(inst) then
     old(inst)
 end
end
end)
	
	inst.AX338BUFF = 55
	inst.MiniMapEntity:SetIcon( "tina.tex" )
	inst:AddTag("tina_build")
	inst:AddComponent("keyhandler")
	inst.components.keyhandler:AddActionListener("tina", TUNING.AX338, "AX338")
	inst.components.keyhandler:AddActionListener("tina", TUNING.KUROIKAZE, "KUROIKAZE")
	inst.components.keyhandler:AddActionListener("tina", TUNING.TEISATUWANA, "TEISATUWANA")
	inst.components.keyhandler:AddActionListener("tina", TUNING.INFO, "INFO")

	inst:DoPeriodicTask(1, function()
		if inst:HasTag("playerghost") then return end
		if (TheWorld:HasTag("cave") or TheWorld.state.isnight or TheWorld.state.isdusk) then
			inst.components.playervision:ForceNightVision(true)
			inst.components.playervision:SetCustomCCTable("images/colour_cubes/beaver_vision_cc.tex")
	else
		if inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HEAD) then
			inst.components.playervision:ForceNightVision(false)
			inst.components.playervision:SetCustomCCTable(nil)
		else
			inst.components.playervision:ForceNightVision(true)
			inst.components.playervision:SetCustomCCTable(nil)
		end
	end
	end)
	inst.exp = 0
	inst.level = 0
end,
function(inst)
	inst.OnSave = function(inst, data)
	data.exp = inst.exp
	data.level = inst.level
end
inst.OnPreLoad = function(inst, data)
	if data.level then
		inst.exp = data.exp
		inst.level = data.level
		inst.Tina_Level(inst)
		inst.components.health:DoDelta(0)
		inst.components.hunger:DoDelta(0)
		inst.components.sanity:DoDelta(0)
	end
	inst.Tina_Level(inst)
end
inst.OnLoad = function(inst)
inst:ListenForEvent("ms_respawnedfromghost", inst.Tina_Level)
if not inst:HasTag("playerghost") then
 inst.Tina_Level(inst)
end
end

inst:ListenForEvent("killed", function(inst, data)
	local victim = data.victim
	if victim:HasTag("monster") and victim:HasTag("hostile") then
	 if inst.level <= 18 then
		inst.exp = inst.exp + math.random(500)
		if inst.exp >= 1000*inst.level then
			 inst.level = inst.level + 1
			 inst.exp = 0
		 end
		 inst.Tina_Level(inst)
	 end	
end
end)
inst:DoPeriodicTask(1, function()
	if inst:HasTag("playerghost") then return end
	if (TheWorld:HasTag("cave") or TheWorld.state.isnight or TheWorld.state.isdusk) then
	 inst.AnimState:SetBuild("tina_night")
	 inst.components.locomotor:SetExternalSpeedMultiplier(inst, "owl", 1.5)
	 inst.components.combat.damagemultiplier = 2
 else
	 inst.AnimState:SetBuild("tina")
	 inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "owl")
	 inst.components.combat.damagemultiplier = 1
 end
 end	)

	inst.soundsname = "tina"
	inst.talker_path_override = "tina/"
	inst.components.health:SetMaxHealth(90)
	inst.components.hunger:SetMax(100)
	inst.components.sanity:SetMax(120)
	
	--Debug
	--inst.components.builder:GiveAllRecipes()
end, 
{"ax338",}
),
-----------------------------------------------------------------------------------------------------------------------------------------------------
Prefab("ax338", function()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("ax338")
	inst.AnimState:SetBuild("ax338")
	inst.AnimState:PlayAnimation("idle")
	
	inst:AddTag("ax338")
	
	inst.entity:SetPristine()
	if not TheWorld.ismastersim then return inst end
	
	inst:AddComponent("weapon")
	inst.components.weapon:SetRange(30)
	inst.components.weapon:SetProjectile("bullet")
	inst.components.weapon:SetOnAttack(function(inst, owner)
		if inst.components.finiteuses.current <=0 then 
			 owner.components.talker:Say("弾丸を補充してください。")
			 inst.components.weapon:SetRange(0)
			 inst.components.weapon:SetProjectile(nil)
			 inst.components.weapon.damage = 20
		end
	 end)
    inst:DoPeriodicTask(.1 ,function(inst, owner)
      if owner then
         if inst.components.finiteuses.current <=0 then 
            inst:AddTag("ax338_Finished")
            owner:AddTag("ax338_Finished")
        end
        if not inst:HasTag("ax338_Finished") then
            inst.components.weapon.damage = owner.AX338BUFF
        end
    end
    end)
	
	inst:AddComponent("trader")
	inst.components.trader:SetAcceptTest(
		function(inst, item)
			if item.prefab == "ax338_dansou" and inst.components.finiteuses:GetPercent() < 1 then
				inst.SoundEmitter:PlaySound("tina/tina_buki/Attack_Foley_0"..( math.ceil( math.random()*3 )))
				return true
			end
		end)
	inst.components.trader.onaccept = 
	function(inst, giver, item)
		if item.prefab == "ax338_dansou" and inst.components.finiteuses:GetPercent() < 1 then
			item:Remove()
			inst.components.finiteuses:SetUses(10)
			inst.components.weapon:SetRange(30)
			inst.components.weapon:SetProjectile("bullet")
		end
	end
 
	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(10)
	inst.components.finiteuses:SetUses(10)
	inst.components.finiteuses:SetOnFinished(function()
		inst.components.weapon:SetRange(0)
		inst.components.weapon:SetProjectile(nil)
		inst.components.weapon.damage = 20
	end)

	inst:AddComponent("inspectable")
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ax338.xml"
 
	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip(function(inst, owner)
		owner.AnimState:OverrideSymbol("swap_body", "swap_ax338", "swap_body")
		owner.AnimState:OverrideSymbol("swap_object", "null", "null")
		owner.AnimState:Show("ARM_carry")
		owner.AnimState:Hide("ARM_normal")
		owner:AddTag("ax338")
		owner.ax338 = inst
		 
		inst:DoPeriodicTask(.3 ,function(inst)
			owner.AnimState:OverrideSymbol("swap_body", "swap_ax338", "swap_body")
			end)
		end)
	inst.components.equippable:SetOnUnequip(function(inst, owner)
		inst:CancelAllPendingTasks()
		owner.AnimState:ClearOverrideSymbol("swap_body")
		owner.AnimState:ClearOverrideSymbol("swap_object")
		owner.AnimState:Hide("ARM_carry")
		owner.AnimState:Show("ARM_normal")
		owner:RemoveTag("ax338")
		owner.ax338 = nil
	end)
	return inst
	end, {}),
Prefab( "bullet", function()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	MakeInventoryPhysics(inst)
	RemovePhysicsColliders(inst)

	inst.AnimState:SetBank("bullet")
	inst.AnimState:SetBuild("bullet")
	inst.AnimState:PlayAnimation("idle")

	if not TheWorld.ismastersim then
		return inst
	end
	inst.entity:SetPristine()
	
	inst:AddComponent("projectile")
	inst.components.projectile:SetSpeed(100)
	inst.components.projectile:SetOnHitFn(
		function(inst, owner) 
			local x,y,z = inst.Transform:GetWorldPosition()
				for i, v in pairs(TheSim:FindEntities(x,y,z,3)) do
					if v and v.components.health and not v.components.health:IsDead() and
					v.components.combat and v ~= inst and not (v.components.follower and
					v.components.follower.leader == owner ) and (TheNet:GetPVPEnabled() or not v:HasTag("player")) then
					if owner and owner:HasTag("KuroiKazeBuff") then
						v.components.combat:GetAttacked( inst, owner.AX338BUFF)
						local fx = SpawnPrefab("explode_small")
						if fx ~= nil then
							fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
							fx.Transform:SetScale(.5, .5, .5)
						end
					else
						v.components.combat:GetAttacked( inst, owner.AX338BUFF)
						local fx = SpawnPrefab("explode_small")
						if fx ~= nil then
							fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
							fx.Transform:SetScale(.5, .5, .5)
						end
						break
						end
					end
						--print("test:"..owner.prefab)
				end
	
	owner:RemoveTag("KuroiKazeBuff")
	owner.AX338BUFF = 55 + (owner.level * 7)
	inst:Remove()
	end)
	inst.components.projectile:SetOnMissFn(inst.Remove)
	inst.components.projectile:SetOnThrownFn(
		 function(inst, owner, taget, player)
			inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
			
			local x0,y0,z0 = inst.Transform:GetWorldPosition()
			local rot = math.ceil(player.Transform:GetRotation()/90)
			if rot == 1	then						--左1 右-1 下0 上2
				inst.Transform:SetPosition( x0-1, 0, z0-2 )
				elseif rot == -1 then 
				inst.Transform:SetPosition( x0-1, 0, z0-2 )
			end
		 end)
	return inst
	end, {}),
	Prefab ("bullet_fx",	function()
		local inst = CreateEntity()
		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddSoundEmitter()
		inst.entity:AddNetwork()
		inst.AnimState:SetBank("bullet_fx")
		inst.AnimState:SetBuild("bullet_fx")
		inst.AnimState:PlayAnimation("idle")
		inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
		MakeInventoryPhysics(inst)
		RemovePhysicsColliders(inst)
		inst:AddTag("FX")
		inst:AddTag("bullet_fx")
		inst.entity:SetPristine()
		if not TheWorld.ismastersim then
			return inst
		end
		
		inst.SoundEmitter:PlaySound("tina/tina_buki/Attack_Fire_01")
		
		inst:DoPeriodicTask(.1, function(inst)
			if inst then
			 local x, y, z = inst.Transform:GetWorldPosition()
			 for k, v in pairs(TheSim:FindEntities(x, y, z, 2)) do
				if v and v.components.health and not v.components.health:IsDead() and v.components.combat and
					 v ~= inst and
					 not (v.components.follower and v.components.follower.leader == inst.owner ) and 
					 (TheNet:GetPVPEnabled() or not v:HasTag("player"))
					 then
					v.components.combat:GetAttacked(inst.owner, 220+(inst.owner.level * 4)) --max 292
					local fx = SpawnPrefab("explode_small")
					if fx ~= nil then
					 fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
					 fx.Transform:SetScale(.5, .5, .5)
				 end
				 inst:Remove()
				 break
			 end
		 end
	 end
	 end)
		inst:DoTaskInTime(2.5, function()
			inst:Remove()
			end)
		return inst
		end),
	Prefab( "ax338_dansou", function()
		 local inst = CreateEntity()

		 inst.entity:AddTransform()
		 inst.entity:AddAnimState()
		 inst.entity:AddNetwork()

		 MakeInventoryPhysics(inst)
		 RemovePhysicsColliders(inst)

		 inst.AnimState:SetBank("ax338_dansou")
		 inst.AnimState:SetBuild("ax338_dansou")
		 inst.AnimState:PlayAnimation("idle")
		 inst.Transform:SetScale(.5, .5, .5)
		 
		 if not TheWorld.ismastersim then
		return inst
	end
	inst.entity:SetPristine()
	
	inst:AddComponent("tradable")
	inst:AddComponent("inspectable")	 
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/ax338_dansou.xml"
	inst:AddComponent("stackable")
	MakeHauntableLaunch(inst)
	return inst
	end, {}),
	Prefab("teisatuwana",
		function()
			local inst = CreateEntity()

			inst.entity:AddTransform()
			inst.entity:AddAnimState()
			inst.entity:AddSoundEmitter()
			inst.entity:AddMiniMapEntity()
			inst.entity:AddNetwork()

			MakeInventoryPhysics(inst)

			inst.AnimState:SetBank("teisatuwana")
			inst.AnimState:SetBuild("teisatuwana")
			inst.AnimState:PlayAnimation("idle")
			inst.Transform:SetScale(.5, .5, .5)

			inst:AddTag("wana")
			
			inst:DoTaskInTime(60,inst.Remove)
			
			inst.entity:SetPristine()

			if not TheWorld.ismastersim then
			return inst
		end


		local function twperiod()
		 x0, y0, z0 = TheWorld.twhost.Transform:GetWorldPosition()
		 for k, v in pairs(TheSim:FindEntities(x0, y0, z0, 50, nil, {"wall", "INLIMBO", "FX"})) do
			if not IsInTable(v, TheWorld.twents) then
				 table.insert(TheWorld.twents, v)
			 end
		 end
		 for k, v in pairs(TheWorld.twents) do
		if v and v:IsValid() and not v:HasTag("canmoveintime") and not (v:HasTag("inforcefield") and v:HasTag("watch_equipped")) then
			 if v.AnimState then
				v.sg:GoToState("idle")
				v.AnimState:Pause()
			end
			v:StopBrain()
			if v.components.combat then
				v.components.combat:SetTarget(nil)
			end
			if v.components.locomotor then
				v.components.locomotor:Stop()
				v.components.locomotor:StopUpdatingInternal()
			end
			if v.components.playercontroller then
				v.components.playercontroller:Enable(false)
			end
			if not v:HasTag("time_stopped") then
				v:AddTag("time_stopped")
				v:PushEvent("time_stopped")
			end
		end
	end
end
local function twresume()
 for k, v in pairs(TheWorld.twents) do
	if v:HasTag("time_stopped") then
		 v:RestartBrain()
		 if v.AnimState then
			v.AnimState:Resume()
		end
		if v.components.locomotor then
			v.components.locomotor:StartUpdatingInternal()
		end
		if v.components.playercontroller then
			v.components.playercontroller:Enable(true)
		end
		v:RemoveTag("time_stopped")
		v:PushEvent("time_resumed")
	end
end
TheWorld.twents = {}
end
local function twtimedone(inst, data)
 if data.name == "the_world" then
	if TheWorld.twtask ~= nil then
		 TheWorld.twtask:Cancel()
		 TheWorld.twtask = nil
	 end
	 twresume()
	 TheWorld:DoTaskInTime(0.1, function()
		 if TheWorld:HasTag("the_world") then
			TheWorld:RemoveTag("the_world")
		end
		end)
end
if data.name == "twreleasesound" then
	if TheWorld.twhost and TheWorld.twhost.SoundEmitter then
		 TheWorld.twhost.SoundEmitter:PlaySound(TheWorld.twreleasese)
	 end
end
end

local function Boom(target)
 if not inst:HasTag("Booming") then inst:AddTag("Booming") else return end
 if inst.owner then
				target.components.health:DoDelta(-(50 + inst.owner.level * 5) ) --max 140
			else 
				target.components.health:DoDelta(-50)
			end
			local fx = SpawnPrefab("explode_small")
			if fx ~= nil then
				fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
			end
			inst.AnimState:PlayAnimation("explode")
			inst.SoundEmitter:PlaySound("dontstarve/bee/beemine_explo")
			
			
			if target then
				if target.AnimState then
					target.AnimState:Pause()
				end
				target:StopBrain()
				if target.components.combat then
					target.components.combat:SetTarget(nil)
				end
				if target.components.locomotor then
					target.components.locomotor:Stop()
					target.components.locomotor:StopUpdatingInternal()
				end
				if target.components.playercontroller then
					target.components.playercontroller:Enable(false)
				end
				if not target:HasTag("stopped") then
					target:AddTag("stopped")
				end
				 inst:DoTaskInTime(1.5,function()
					if target:HasTag("stopped") then
					 target:RestartBrain()
					 if target.AnimState then
						target.AnimState:Resume()
					end
					if target.components.combat then
						target.components.combat:SetTarget(inst.owner)
					end
					if target.components.locomotor then
						target.components.locomotor:StartUpdatingInternal()
					end
					if target.components.playercontroller then
						target.components.playercontroller:Enable(true)
					end
					target:RemoveTag("stopped")
				end
				end)
				 inst:DoTaskInTime(2.6,function()inst:Remove()inst:RemoveTag("Booming")end)
			 end
			 
		 end
		 
		 inst:DoPeriodicTask(0 ,function(inst) 
		 local x,y,z = inst.Transform:GetWorldPosition()
		 for k, v in pairs(TheSim:FindEntities(x,y,z,1)) do
			
			if v and v.components.health and not v.components.health:IsDead() and v.components.combat and
				 v ~= inst and
				 not (v.components.follower and v.components.follower.leader == inst.owner ) and 
				 (TheNet:GetPVPEnabled() or not v:HasTag("player"))
				 then
				 Boom(v)
			 end
		 end
		 end)

		 return inst
		 end, {}
		 )