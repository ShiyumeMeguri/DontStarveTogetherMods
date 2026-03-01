local Widget = require "widgets/widget"
local Image = require "widgets/image"

local hane = Class(Widget, function(self, atlas, tex, x, y, z)
	self.posX = 0
	self.posY = 0
	self.endX = 0
	self.Alpha = TUNING.HANEAPLHA
	self.Angle = 180
	self.Gyaku = false
	Widget._ctor(self, "hane")
	self.image = self:AddChild(Image())
    self.image:SetTexture(atlas, tex, tex) 
	self.image:SetFadeAlpha(self.Alpha)
	if math.random()<0.1 then
	self.image:SetScale(1,1,1)
	elseif math.random()>0.3 and math.random()<0.5 then
	self.image:SetScale(.7,.7,.7)
	elseif math.random()>0.5 and math.random()<0.6 then
	self.image:SetScale(.6,.6,.6)
	elseif math.random()>0.6 and math.random()<0.8 then
	self.image:SetScale(.56,.56,.56)
	else self.image:SetScale(.9,.9,.9)
	end
	self:SetPosition(x or 0, y or 200, z or 0)
	function self:SetTint(a,b,c,d)
		self.image:SetTint(a,b,c,d)
	end
	ThePlayer:DoPeriodicTask(0.2, function()
		if self.posY <= -150 then
			self.posY = 910
			self.endX = self.posX - 300 + math.random() * 800
			self.Alpha = TUNING.HANEAPLHA
		end
	end)
	
	self:StartUpdating()
end)

function hane:fall()
	if self.Gyaku == false then
		if self.Angle >= -180 then 
			self.Angle = self.Angle - 0.5
			else
		self.Gyaku = true
		end
		else 
		self.Angle = 180 
		self.Gyaku = false
	end
	self.posY = self.posY - 1.5 - math.random() * .5
end

function hane:OnUpdate(dt)
	self:fall()
	
	if self.posX < self.endX and self.posX ~= self.endX then
		self.posX = self.posX + math.random()
		else
		self.posX = self.posX - math.random()
	end
	
	--リセット
	if self.posY <= -150 then
		if math.random() < .5 then
			self.posX = math.ceil(math.random() * RESOLUTION_X/2)
		else
			self.posX = math.ceil(math.random() * (-RESOLUTION_X/2))
		end
	end
	if self.posY < 100 then
		self.Alpha = self.Alpha - 0.05
		if self.Alpha <= 0 then
		self.posY = -200
		end
	end
	
	--状態更新
	self:UpdatePosition(self.posX,self.posY)
	self.image:SetFadeAlpha(self.Alpha)
	self.image:SetRotation(self.Angle)
end

return hane