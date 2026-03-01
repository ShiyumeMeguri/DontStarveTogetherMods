local Dakimakura = Class(function(self, inst)
    self.inst = inst
end)

function Dakimakura:nebou(invobject, doer)
	if not doer:HasTag("tenshi") then
		invobject.components.finiteuses:Use(1)
		doer:PushEvent("yawn", { grogginess = 10 + math.random() * 30 })
		doer.components.health:StartRegen(1 +  math.random(), 10)
		doer.components.health.absorb = 0.7
		doer.components.combat.damagemultiplier = 1
		doer:DoTaskInTime(10, function()
		doer.components.health:StopRegen()
		doer.components.health.absorb = 0.3
		doer.components.combat.damagemultiplier = 0.7
		end)
		return true
	else
		doer.components.talker:Say("この姿は眠れない...")
		return false
	end
end

return Dakimakura