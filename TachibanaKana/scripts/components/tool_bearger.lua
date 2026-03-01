local ToolBearger = Class(function(self, inst)
    self.inst = inst

    self.numRings = 4
    self.ringDelay = 0.2
    self.initialRadius = 1
    self.radiusStepDistance = 4
    self.pointDensity = .25
    self.damageRings = 2
    self.destructionRings = 3
    self.platformPushingRings = 2
    self.noTags = { "FX", "NOCLICK", "DECOR", "INLIMBO" }
    self.destroyer = false
    self.burner = false
    self.groundpoundfx = "groundpound_fx"
    self.groundpoundringfx = "groundpoundring_fx"
    self.groundpounddamagemult = 1
    self.groundpoundFn = nil
    -- 破坏范围
    self.damageRanage = 3
	
end)

function ToolBearger:GetPoints(pt)
    local points = {}
    local radius = self.initialRadius

    for i = 1, self.numRings do
        local theta = 0
        local circ = 2*PI*radius
        local numPoints = circ * self.pointDensity
        for p = 1, numPoints do

            if not points[i] then
                points[i] = {}
            end

            local offset = Vector3(radius * math.cos(theta), 0, -radius * math.sin(theta))
            local point = pt + offset

            table.insert(points[i], point)

            theta = theta - (2*PI/numPoints)
        end

        radius = radius + self.radiusStepDistance

    end
    return points
end

local WALKABLEPLATFORM_TAGS = {"walkableplatform"}

function ToolBearger:DestroyPoints(points, breakobjects, dodamage, pushplatforms)
    local getEnts = breakobjects or dodamage
    local map = TheWorld.Map
    self.inst.AnimState:PlayAnimation("jumpout")
-- 初始化时赋值核心范围
self.damageRange = 8 -- 替代错误的self.damageRanage
-- 若需兼容旧代码，可加映射
self.damageRanage = self.damageRange
    -- 固定伤害值（优先直接指定，避免组件依赖问题）
    local damage_amount = 60 
    -- 兼容角色自身攻击伤害（可选）
    if self.inst.components.combat and self.inst.components.combat.defaultdamage then
        damage_amount = self.inst.components.combat.defaultdamage
    end

    if dodamage then
        self.inst.components.combat:EnableAreaDamage(false)
    end

    for k, v in pairs(points) do
        if getEnts then
            -- 这个ents列表能找到树木/矿石，说明查找逻辑有效，复用它！
            -- 【关键修改1】临时移除self.noTags，避免过滤掉生物（测试后可按需加回）
            local ents = TheSim:FindEntities(v.x, v.y, v.z, self.damageRanage or 7, nil) -- 去掉self.noTags  damageRanage范围5格子
            if #ents > 0 then
                -- 调试：打印找到的所有实体（确认包含生物）
                print("总找到实体数：", #ents)
                
                if breakobjects then
                    for i, v2 in ipairs(ents) do
                        -- 原有破坏物品逻辑（保留）
                        if v2 ~= self.inst and v2:IsValid() then
                            if string.find(v2:__tostring(), "stalagmite") or string.find(v2:__tostring(), "spiderhole") then 
                                v2.components.workable:Destroy(self.inst)
                            elseif self.destroyer and
                                v2.components.workable ~= nil and
                                v2.components.workable:CanBeWorked() and
                                v2.components.workable.action ~= ACTIONS.NET then
                                if v2:HasTag("structure") then break 
                                elseif v2:HasTag("tree") or v2:HasTag("boulder") then
                                    v2.components.workable:Destroy(self.inst)
                                end
                            end
                        end
                    end
                end

                -- ======================================
                -- 【核心修复】复用有效ents列表，直接伤害生物
                -- ======================================
                for i, creature in ipairs(ents) do
                    -- 核心筛选：只针对有血量、未死亡、非自身的生物
                    if creature ~= self.inst 
                        and creature:IsValid() 
                        and creature.components.health ~= nil 
                        and not creature.components.health:IsDead() then
                        
                        -- 排除树木/矿石/建筑（避免误伤破坏目标）
                        if not creature:HasTag("tree") 
                            and not creature:HasTag("boulder") 
                            and not creature:HasTag("structure") then
                            
                            -- 调试：打印找到的生物名称
                            print("找到可伤害生物：", creature.prefab or creature.name or "未知")
                            
                            -- 方式1：强制扣血（跳过所有防御/仇恨，优先确保生效）
                            creature.components.health:DoDelta(-damage_amount, false, self.inst.prefab, "groundpound")
                            
                            -- 方式2（可选）：原生攻击（触发仇恨，注释方式1后启用）
                            -- if self.inst.components.combat then
                            --     self.inst.components.combat:AttackTarget(creature) -- 饥荒原生攻击接口
                            -- end

                            -- 视觉反馈（可选，添加伤害特效，更直观）
                            if creature.components.combat then
                                creature.components.combat:GetAttacked(self.inst, damage_amount)
                            end
                        end
                    end
                end
            end

            -- 原有推动平台逻辑（无修改）
            if pushplatforms then
                local platform_ents = TheSim:FindEntities(v.x, v.y, v.z, (self.damageRanage or 7) + TUNING.MAX_WALKABLE_PLATFORM_RADIUS, WALKABLEPLATFORM_TAGS, self.noTags)
                for i, p_ent in ipairs(platform_ents) do
                    if p_ent ~= self.inst and p_ent:IsValid() and p_ent.Transform ~= nil and p_ent.components.boatphysics ~= nil then
                        local v2x, v2y, v2z = p_ent.Transform:GetWorldPosition()
                        local mx, mz = v2x - v.x, v2z - v.z
                        if mx ~= 0 or mz ~= 0 then
                            local normalx, normalz = VecUtil_Normalize(mx, mz)
                            p_ent.components.boatphysics:ApplyForce(normalx, normalz, 3)
                        end
                    end
                end
            end

            -- 原有特效生成逻辑（无修改）
            if map:IsPassableAtPoint(v:Get()) then
                SpawnPrefab(self.groundpoundfx).Transform:SetPosition(v.x, 0, v.z)
            end
        end
    end

    if dodamage then
        self.inst.components.combat:EnableAreaDamage(true)
    end
end



local function OnDestroyPoints(inst, self, points, breakobjects, dodamage, pushplatforms)
    self:DestroyPoints(points, breakobjects, dodamage, pushplatforms)
end

function ToolBearger:GroundPound()
    --检查饥饿值
    -- if self.inst.components.hunger:GetPercent() < 0.9 then
    if self.inst.components.hunger.current < 69 or self.inst.prefab  ~= "kana" then -- 技能加强，降低使用条件
        self.inst.components.talker:Say(TUNING.RANGE_BEARPOWER_WARNING)
        --动作，取消僵直
        -- self.inst:PushEvent("emote", { anim = "emoteXL_annoyed", mounted = true, mountsound = "grunt", mountsounddelay = 12 * FRAMES } )
        return
    end
    --减少饥饿值
    self.inst.components.hunger:DoDelta(TUNING.RANGE_BEARPOWER_HUNGER)
    
    local pt = self.inst:GetPosition()
    SpawnPrefab(self.groundpoundringfx).Transform:SetPosition(pt:Get())
    local points = self:GetPoints(pt)
    local delay = 0
    for i = 1, self.numRings do
        self.inst:DoTaskInTime(delay, OnDestroyPoints, self, points[i], i <= self.destructionRings, i <= self.damageRings, i <= self.platformPushingRings)
        delay = delay + self.ringDelay
    end

    if self.groundpoundFn ~= nil then
        self.groundpoundFn(self.inst)
    end
end

return ToolBearger
