local Widget = require "widgets/widget"
local Image = require "widgets/image"

local yukikaze_skill = Class(Widget, function(self, atlas, tex, x, y, z, skillname, modename)
	Widget._ctor(self, "yukikaze_skill")
	self.image = self:AddChild(Image())
    self.image:SetTexture(atlas, tex, tex) 
	self:SetPosition(x or 0, y or 200, z or 0)
	function self:SetTint(a,b,c,d)
		self.image:SetTint(a,b,c,d)
	end
end)

return yukikaze_skill