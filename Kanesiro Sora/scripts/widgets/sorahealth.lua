local Widget = require "widgets/widget"
local Image = require "widgets/image"

local sorahealth = Class(Widget, function(self, atlas, tex, x, y, z, gyaku)
	self.posX = x
	self.posY = y
	if gyaku == false then
	self.Angle = 180
	else
	self.Angle = -180
	end
	self.Gyaku = false
	self.Gyaku_unten = gyaku or false
	Widget._ctor(self, "sorahealth")
	self.image = self:AddChild(Image())
    self.image:SetTexture(atlas, tex, tex) 
	self:SetPosition(x or 0, y or 100, z or 0)
	function self:SetTint(a,b,c,d)
		self.image:SetTint(a,b,c,d)
	end
	
	self:StartUpdating()
end)
		
function sorahealth:OnUpdate(dt)
if ThePlayer:HasTag("playerghost") then self:Hide() else self:Show() end

if  self.Gyaku_unten == false then
	if self.Gyaku == false then
			if self.Angle >= -180 then 
				self.Angle = self.Angle - ThePlayer.replica.health:GetPercent()
				else
			self.Gyaku = true
			end
		else 
		self.Angle = 180 
		self.Gyaku = false
	end
else
		if self.Gyaku == false then
			if self.Angle <= 180 then 
				self.Angle = self.Angle + ThePlayer.replica.health:GetPercent()
				else
			self.Gyaku = true
			end
			else 
			self.Angle = -180 
			self.Gyaku = false
		end
	end
	self.image:SetRotation(self.Angle)
end

return sorahealth