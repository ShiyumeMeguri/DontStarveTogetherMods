local function oncurrent(self,current)
    self.inst.currentyukikaze:set(current)
end

local Yukikaze_exp = Class(function(self,inst)
    self.inst = inst
    self.max = 1000000
    self.min = 0
	self.current = self.min
    self.overridestarvefn = nil
end,
nil,
{
    current = oncurrent
})

function Yukikaze_exp:DoDelta(delta)  		
    self.current = math.clamp(self.current + delta, self.min, self.max)
    self.inst:PushEvent("Yukikaze_exp")
end
function Yukikaze_exp:OnSave()
	return {
	current = self.current
	}
end

function Yukikaze_exp:OnLoad(data)
	if data.current then
        self.current = data.current
    end
end
return Yukikaze_exp