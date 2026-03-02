local Screen = require "widgets/screen"
local ImageButton = require "widgets/imagebutton"
local Image = require "widgets/image"
local Widget = require "widgets/widget"
local PopupDialogScreen = require "screens/popupdialog"

local Kekon = Class(Screen, function(self,owner)
    Screen._ctor(self, "Kekon")
	
    self.active = true
    SetPause(true,"pause")

    self.yukikaze_kekon = self:AddChild(ImageButton("images/yukikaze_kekon.xml", "yukikaze_kekon.tex"))
    self.yukikaze_kekon.image:SetTint(1,1,1,1)
	self.yukikaze_kekon:SetOnClick(function() self:doconfirmquit() end)	

    TheInputProxy:SetCursorVisible(true)
	self:StartUpdating()
end)

function Kekon:doconfirmquit()
 	self.active = false 
	local function dokekon()
	TheFrontEnd:PopScreen()
	TUNING.ONKEKON=1
	TUNING.KEKONSHOW=1
	end

	if TUNING.ONKEKON~=1 then
	local confirm = PopupDialogScreen("けっこんをしますか？", "Are you sure you want to get married?", {{text="はい", cb = dokekon},{text="キャンセル", cb = function() TheFrontEnd:PopScreen() end}  })

	TheFrontEnd:PushScreen(confirm)
	else
	local confirm = PopupDialogScreen("あなたはもう結婚しました", "You are already married", {{text="公式サイト", cb = function() VisitURL("http://www.azurlane.jp/") end},{text="はい", cb = function() TheFrontEnd:PopScreen() end} })

	TheFrontEnd:PushScreen(confirm)
	end
end


function Kekon:OnUpdate(dt)
	self.yukikaze_kekon:SetPosition(TUNING.MOVEIMAGE1,-170,0)
end

return Kekon
