local function onmax(self,max)
	self.inst.koukan_max:set(max)
end

local function oncurrent(self,current)
	self.inst.koukan_current:set(current)
end

local koukan = Class(function(self, inst)
	self.inst = inst
		self.maxtimepiont = 100
		self.currenttimepiont = 0
end,
nil,
{
	maxtimepiont = onmax,
	currenttimepiont = oncurrent,
})

function koukan:DoDelta(delta)
		local val = self.currenttimepiont + delta
		if val >= self.maxtimepiont then
				self.currenttimepiont = self.maxtimepiont
	elseif val <= 0 then
				self.currenttimepiont = 0
	else
		self.currenttimepiont = val
	end
end

function koukan:GetPercent()
		return self.currenttimepiont/self.maxtimepiont
end

function koukan:OnSave()
	return 
	{
		currenttimepiont = self.currenttimepiont,
		maxtimepiont = self.maxtimepiont,
	}
end
function koukan:OnLoad(data)
    self.currenttimepiont = data.currenttimepiont
    self.maxtimepiont = data.maxtimepiont
end

return koukan