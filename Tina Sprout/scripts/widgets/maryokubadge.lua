local UIAnim = require "widgets/uianim"
local Widget = require "widgets/widget"
local Text = require "widgets/text"

local MaryokuBadge = Class(Widget, function(self, owner)
	Widget._ctor(self, "maryoku")
	self.owner = owner
	
	self.percent = 1
	
    self.anim = self:AddChild(UIAnim())
	
    self.anim:GetAnimState():SetBank("maryoku")
    self.anim:GetAnimState():SetBuild("maryoku")
	self.anim:GetAnimState():PlayAnimation("anim")
	self.anim:GetAnimState():SetPercent("anim", self.percent)
    self.anim:SetClickable(true)
	
    self.underNumber = self:AddChild(Widget("undernumber"))
	
    self.num = self:AddChild(Text(BODYTEXTFONT, 33))
    self.num:SetHAlign(ANCHOR_MIDDLE)
    self.num:SetPosition(5, 0, 0)
    self.num:Hide()

	owner:ListenForEvent("maryoku_maxdirty",function(owner,data)
		self.percent = math.abs((owner.maryoku_current:value()/owner.maryoku_max:value()) -1)
	end)
	owner:ListenForEvent("maryoku_currentdirty",function(owner,data)
		self.percent = math.abs((owner.maryoku_current:value()/owner.maryoku_max:value()) -1)
	end)
	
	self:StartUpdating()
end)

function MaryokuBadge:OnGainFocus()
    MaryokuBadge._base.OnGainFocus(self)
    self.num:Show()
end

function MaryokuBadge:OnLoseFocus()
    MaryokuBadge._base.OnLoseFocus(self)
    self.num:Hide()
end

function MaryokuBadge:OnUpdate(dt)
	if not self.owner:HasTag("playerghost") then 
		self.anim:Show()
		self.anim:GetAnimState():SetPercent("anim", self.percent)
		self.num:SetString(tostring(math.ceil(self.owner.maryoku_current:value())))
	else
		self.anim:Hide()
		self.num:Hide()
	end
end

return MaryokuBadge
