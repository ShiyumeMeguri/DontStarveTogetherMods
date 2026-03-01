local function onmax(self,max)
	self.inst.maryoku_max:set(max)
end

local function oncurrent(self,current)
	self.inst.maryoku_current:set(current)
end

local maryoku = Class(function(self, inst)
	self.inst = inst
	self.maxtimepiont = 310
	self.currenttimepiont = 310
	inst:DoPeriodicTask(1, function()
		self:DoDelta(1.4)
	end)
end,
nil,
{
	maxtimepiont = onmax,
	currenttimepiont = oncurrent,
})

function maryoku:DoDelta(delta)
		local val = self.currenttimepiont + delta
		if val >= self.maxtimepiont then
				self.currenttimepiont = self.maxtimepiont
	elseif val <= 0 then
				self.currenttimepiont = 0
	else
		self.currenttimepiont = val
	end
end

function maryoku:OnSave()
	return 
	{
		currenttimepiont = self.currenttimepiont,
		maxtimepiont = self.maxtimepiont,
	}
end
function maryoku:OnLoad(data)
    self.currenttimepiont = data.currenttimepiont
    self.maxtimepiont = data.maxtimepiont
end

return maryoku