AddGamePostInit(function()
    AAB_ReplaceCharacterLines("wortox")
end)

-- AAB_ActivateSkills --这个函数是开启某个角色后会载入对应角色名称的技能树 -- 目前已经被我限制成为只能某个指定人物名称 kana 才能开启
AAB_ActivateSkills("wortox")-- 因为我限制只能kana使用 

--[[]]--
--
---如下的这个函数 AAB_AddClickAction 在 modmain里面 叫 追加鼠标行为，不方便hook pointspecialactionsfn，伍迪、大力士这种角色会把这个变量清空
---@param getactionfn function (inst, target, pos, useitem, right, bufs)
AAB_AddClickAction(function(inst, target, pos, useitem, right, bufs)  --- 右键触发机制 

-- if inst.prefab == "kana" then  end -----私有化代码 如下两个代码就可以让其他人无法用这个技能 
    if #bufs <= 0 --这个好像是和饱食度有关系
        and right
        and not target
        and not useitem
		and inst.CanBlinkTo
    then
        local canblink
        if inst.checkingmapactions and inst.prefab == "kana" then   
            canblink = inst.CanBlinkFromWithMap(inst:GetPosition())
        elseif inst.prefab == "kana" then   
            canblink = inst.CanBlinkTo(self,pos)---  这个去掉后 会导致 无法飞跃了
        end
		
        if canblink and inst.CanSoulhop and inst:CanSoulhop() and inst.prefab == "kana" then  
            return ACTIONS.BLINK
        end
    end
end)


----------------------------------------------------------------------------------------------------


-- 1. 修正CanBlinkTo函数：第一个参数为self（inst），第二个为pt（坐标点）
local function CanBlinkTo(self, pt)
    -- 先判断pt是否有效，再正确获取坐标
   -- if not pt then return false end
   -- local x, y, z = pt.x, pt.y, pt.z
    -- 正确调用IsPassableAtPoint（需要x/y/z三个参数）
    return TheWorld.Map:IsPassableAtPoint(pt:Get()) and not TheWorld.Map:IsGroundTargetBlocked(pt)
end


local function CanBlinkFromWithMap(pt)
    return true -- NOTES(JBK): Change this if there is a reason to anchor Wortox when trying to use the map to teleport.
end

local function ReticuleTargetFn(inst)
    return ControllerReticle_Blink_GetPosition(inst, inst.CanBlinkTo)
end

local function CanSoulhop(inst, souls)
    if inst.replica.hunger and inst.replica.hunger:GetCurrent() >= (souls or 1) * 5 then
        local rider = inst.replica.rider
        if rider == nil or not rider:IsRiding() then
            return true
        end
    end
    return false
end

-- 3. 修复TryToPortalHop的nil判断
local function TryToPortalHop(inst, souls, consumeall)
    -- 先判断hunger组件是否存在
    if not inst.components.hunger then return false end
    local cost = (souls or 1) * 5
    if inst.components.hunger.current < cost then
        return false
    end
    inst.components.hunger:DoDelta(-cost)
    return true
end



	 --- if inst.prefab == "wortox" then return end   如果当前人物是沃拓克斯 恶魔人 那么下面的代码无效  下面的代码很可能是为了解决和恶魔人技能冲突而设定的 因为不是 恶魔人的人物是用饱食度来换取瞬移功能的  所以推测 下面的代码是让非恶魔人的人物用另一种方式 瞬移  
	  --和我推测的一样 如果取消上面的代码  恶魔人就只能和普通人物一样靠饱食度飞行
---这个代码必须启动  对角色的追加和修改都是用的 AddPlayerPostInit，你只想想修改某个角色换成 AddPrefabPostInit 就行（这个是作者给的建议 但是 试过了 反而会导致报错 所以没有用 AddPrefabPostInit）
AddPlayerPostInit(function(inst)  


   if inst.prefab == "wortox" then return end  ---如果当前人物是沃拓克斯 恶魔人 那么下面的代码无效  下面的代码很可能是为了解决和恶魔人技能冲突而设定的 因为不是 恶魔人的人物是用饱食度来换取瞬移功能的  所以推测 下面的代码是让非恶魔人的人物用另一种方式 瞬移  
  --和我推测的一样 如果取消上面的代码  恶魔人就只能和普通人物一样靠饱食度飞行
  
	 
		inst:AddTag("soulstealer")   --- 试试看能否屏蔽 不影响   好像成功了  除了 恶魔人和kana都无法飞了 
		inst.CanSoulhop = CanSoulhop-- --- 试试看能否屏蔽 不影响   用灵魂回复血量    好像成功了  除了 恶魔人和kana 都无法飞了 --  这个开启后 可以右键 有瞬移提示 但是做不到 地图也有提示但是也做不到 
	
	
	   inst.CanBlinkTo = CanBlinkTo -- 不能屏蔽 会报错
	
		inst.CanBlinkFromWithMap = CanBlinkFromWithMap
		if not inst.components.reticule then
			inst:AddComponent("reticule")
		end
		inst.components.reticule.targetfn = ReticuleTargetFn
		inst.components.reticule.ease = true
		if not TheWorld.ismastersim then return end
		inst.TryToPortalHop = TryToPortalHop
		inst.DoCheckSoulsAdded = function() end

end)
	
	
 ---如果当前人物是沃拓克斯 恶魔人 那么下面的代码无效  下面的代码很可能是为了解决和恶魔人技能冲突而设定的 因为不是 恶魔人的人物是用饱食度来换取瞬移功能的  所以推测 下面的代码是让非恶魔人的人物用另一种方式 瞬移  
  --和我推测的一样 如果取消上面的代码  恶魔人就只能和普通人物一样靠饱食度飞行
  


