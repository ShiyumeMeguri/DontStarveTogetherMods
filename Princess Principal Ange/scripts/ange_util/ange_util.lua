local ThePlayer = GLOBAL.ThePlayer
local TheInput = GLOBAL.TheInput
local TheNet = GLOBAL.TheNet

local KEY_R = GLOBAL.KEY_R
AddModRPCHandler(modname, "R", function(player)
	if not player:HasTag("playerghost") and player.prefab == "ange" then
		if player.level > 50 then player.level = 50 end
			if player.level < 50 then
				player.components.talker:Say("Lv ".. (player.level).."")
			else
				player.components.talker:Say("Lv 50")
		end
	end
end)

local ange_handlers = {}
AddPlayerPostInit(function(inst)
	inst:DoTaskInTime(0, function()
		if inst == GLOBAL.ThePlayer then
			if inst.prefab == "ange" then
				ange_handlers[0] = TheInput:AddKeyDownHandler(KEY_R, function()
					SendModRPCToServer(MOD_RPC[modname]["R"])
				end)

			else
				ange_handlers[0] = nil

			end
		end
	end)
end)