local UIAnim = require "widgets/uianim"
local Widget = require "widgets/widget"
local Text = require "widgets/text"

local koukan = Class(Widget, function(self, owner)
	Widget._ctor(self, "koukan")
	self.owner = owner
	self:SetPosition(0, 0, 0)
	self:SetScale(1,1,1)

    self.num = self:AddChild(Text(BODYTEXTFONT, 33))
    self.num:SetVAlign(ANCHOR_MIDDLE)
    self.num:SetPosition(5, -50, 0)
	self.num:SetScale(.75,.75,.75)
	self.num:MoveToFront()
	
	self.num.current = owner.koukan_current:value()
	self.num.max = owner.koukan_max:value()
	self.percent = self.num.current/self.num.max
	
    self.anim = self:AddChild(UIAnim())
    self.anim:GetAnimState():SetBank("koukan")
    self.anim:GetAnimState():SetBuild("koukan")
	self.anim:GetAnimState():PlayAnimation("anim")
	self.anim:GetAnimState():SetPercent("anim", self.percent * .99)
    self.anim:SetClickable(true)

	owner:ListenForEvent("koukan_maxdirty",function(owner,data) 		
		self.num.max = owner.koukan_max:value()
		self.percent = self.num.current/self.num.max  
	end)
	owner:ListenForEvent("koukan_currentdirty",function(owner,data)		
		self.num.current = owner.koukan_current:value()
		self.percent = self.num.current/self.num.max  
	end)
	
	self:StartUpdating()
end)

function koukan:OnUpdate(dt)
	self.anim:GetAnimState():SetPercent("anim", self.percent * .99)
	local str = string.format("%3d",self.num.current)
	self.num:SetString("好感:"..str)
end

return koukan
