local Ch = locale == "zh" or locale == "zhr"

name = Ch and [[ 橘佳奈]] or [[ Tachibana kana]]


description = "出自 极黑的布伦希尔特 原作者 他删了这个作品后消失了 我很喜欢这个人物所以复活了她 并且强化了功能  "
author = "原作者 終焉さくら 目前消失 。现任作者：卖女孩小火柴"
version = "71" 
forumthread = ""
api_version = 10

priority = 0

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false

shipwrecked_compatible = false

all_clients_require_mod = true


icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {
"character",
}
--如下代码是引用 全能力 作者  绯世行 的 所有能力 3366313760  用来生产对应的固定参数 
--如下代码是引用 全能力 作者  绯世行 的 所有能力 3366313760  用来生产对应的固定参数 
---生成快捷键选项表  
local ON = { description = "On" or "开", data = true }
local OFF = { description = "Off" or "关", data = false }
function SWITCH()
    return { ON, OFF }
end

local ALPHA = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
    "U", "V", "W", "X", "Y", "Z", "LAlt"}

function KEYSLIST3(closable, right_mouse)
    local list = {}
    if closable then
        list[#list + 1] = OFF
    end
    if right_mouse then
        list[#list + 1] = { description = "Mouse right" or "鼠标右键", data = "RIGHT" }
    end

    for i = 1, #ALPHA do
        list[#list + 1] = { description = ALPHA[i], data = ALPHA[i] }
    end
    return list
end

local EPSILON = 1e-10

local function IsEqual(a, b)
    if a == b then
        return true
    end
    if a == true or a == false or b == true or b == false then
        return false
    end
    return (a > b and (a - b) or (b - a)) < EPSILON
end

---生成数字选择表
---@param tab any 可选数字
---@param default any 默认值
---@param closable any 是否含有关闭选项
function NUMLIST(tab, default, closable, scale, prefix)
    scale = scale or 1
    prefix = prefix or ""
    local list = {}
    if closable then
        list[#list + 1] = { description = "Default" or "默认", data = false }
    end
    for i = 1, #tab do
        local val = tab[i]
        list[#list + 1] = { description = prefix .. (val * scale) .. (IsEqual(val, default) and "-default" or ""), data = tab[i] }
    end
    return list
end

local function TITLE(label)
    return { name = "", label = label, hover = "", options = { { description = "", data = false }, }, default = false }
end

--- gap是小数可能有误差，科雷又是用等号判断的，导致上下滑动对不上选项，有些值可以有些值会跳动
local function NUM_RANGE(...)
    local list = {}
    local count = 0
    local args = { ... }
    local group = 1
    while group < #args do
        local min, max, gap = args[group], args[group + 1], args[group + 2]
        gap = gap or 1
        for val = min, max, gap do
            count = count + 1
            list[count] = val
        end
        group = group + 3
    end
    return list
end

local function PERCENTAGE_LIST(min, max, gap, default)
    gap = gap or 1
    local list = {}
    local count = 0

    if default then
        count = count + 1
        list[count] = { description = "默认", data = false }
    end

    for val = min, max, gap do
        count = count + 1
        list[count] = { description = val .. "%", data = val }
    end
    return list
end
--configuration_options = {}
--如下代码是引用 全能力 作者  绯世行 的 所有能力 3366313760  用来生产对应的固定参数 
--如下代码是引用 全能力 作者  绯世行 的 所有能力 3366313760  用来生产对应的固定参数 


local kana_alpha = 
{
	{description = "B", key = 98},
	{description = "G", key = 103},
	{description = "J", key = 106},
	{description = "R", key = 114},
	{description = "T", key = 116},
	{description = "V", key = 118},
	{description = "X", key = 120},
	{description = "Z", key = 122},
	{description = "LAlt", key = 308},
	{description = "LCtrl", key = 306},
	{description = "LShift", key = 304},
	{description = "Space", key = 32},
}

local keyslist = {}
for i = 1,#kana_alpha do keyslist[i] = {description = kana_alpha[i].description, data = kana_alpha[i].key} end

	
configuration_options =
Ch and
{
    {
        name = "kana_Super_Atk",
        label = "跳劈开关",
       -- options = KEYSLIST3(true),---这个KEYSLIST3(true) 开启后无法读取存档 在解决
	    options = keyslist,
        default = 114,---默认是LAlt 避免和 跳劈冲突跳劈是 r
    },
   
	
	{
        name = "bearger_oper",
        label =  "熊大震荡波" or "Bearger's Power",
        hover = "按 v 摧毁树木和石头但是耗费20点饥饿",
         options =
         {
              {description = "关闭", data = false, hover = "close"},
              {description = "开启", data = true, hover = "open"},
         },
         default = true,
    },

    {
        name = "bearger_power",
        label = "震荡波快捷键V" or "Key of Bearger's Power",
        hover = "默认快捷键v",
        options = keyslist,
        default = 118, --V
    },
	--代码是引用 全能力 作者  绯世行 的 所有能力 3366313760 
	---大力士能力    ---成功
	
	
	
    {
        name = "willow_lighter",
        label = "薇洛技能" or "Willow Lighter",
        hover = "Player unlocks Willow lighter recipe and can collect embers and use skills." or "玩家解锁薇洛打火机配方，并且可以收集余烬和使用技能。",
        options =
         {
              {description = "关闭", data = false, hover = "close"},
              {description = "开启", data = true, hover = "open"},
         },
        default = true,
    },
	
    {
        name = "wortox_blink",
        label =  "沃拓克斯能力" or "Wortox Blink",
        options =
         {
              {description = "关闭", data = false, hover = "close"},
              {description = "开启", data = true, hover = "open"},
         },
        default = true,
    },

	{
        name = "willow_bernie",
        label = "薇洛的小熊 伯尼" or "Willow Bernie",
        hover = "Player can craft and use Bernie." or "玩家可以制作和使用伯尼。",
        options =
         {
              {description = "关闭", data = false, hover = "close"},
              {description = "开启", data = true, hover = "open"},
         },
        default = true,
    },
 

--[[-- 能力 直接用代码解决 代码用在目录scripts/kana.lua
 {
        name = "kana_DodgeKey",
        label = "跳跃按键",
        options = keyslist,
        default = 308,---默认是LAlt 避免和 跳劈冲突跳劈是 r
    },
{
        name = "kana_CrossEdge",
        label = "跳跃穿越边缘 别开会掉入海里",
        options =
		 {
              {description = "关闭", data = false, hover = "close"},
              {description = "开启", data = true, hover = "open"},
         },
        default = false,
    },








{
        name = "heavy_not_slowdown",-- 这个代码启动的是目录里面modmain/abilities/heavy_not_slowdown.lua里面的内容
        label = "背重物不减速" or "No Slowdown When Heavy",
         options =
         {
              {description = "关闭", data = false, hover = "close"},
              {description = "开启", data = true, hover = "open"},
         },
        default = true,
    },
	
	


	    {
        name = "time_stop",
        label = "时停" or "Time Stop key",
        hover =
            "When the player presses the shortcut key to trigger the time stop, the surrounding creatures will stop for a period of time, lasting 8 seconds, and the skills will cool down for 60 seconds" or
            "玩家按下快捷键触发时间停止，周围的生物都会停止动作一段时间，持续8秒，技能冷却60秒",
        options =
         {
              {description = "关闭", data = false, hover = "close"},
              {description = "开启", data = true, hover = "open"},
         },
        default = false,
    },
	
	]]
	--代码是引用 全能力 作者  绯世行 的 所有能力 3366313760 
}

