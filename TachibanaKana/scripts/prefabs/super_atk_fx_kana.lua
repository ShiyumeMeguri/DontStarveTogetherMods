local assets =
{
	Asset("ANIM", "anim/shadow_knight.zip")
}

local function fx1()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()
    inst.entity:AddAnimState()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")

    inst.AnimState:SetBank("shadow_knight") 
    inst.AnimState:SetBuild("shadow_knight")
	---身上纠缠着黑色影子动画特效 已经屏蔽
  --  inst.AnimState:PlayAnimation("transform", true)  --c_findnext("super_atk_fx", 4).AnimState:OverrideSymbol("leg_up", "swap_whip", "a")
    --inst inst.AnimState:OverrideSymbol("face", "swap_whip", "a")---身上纠缠着黑色影子动画特效
    --inst inst.AnimState:OverrideSymbol("head", "swap_whip", "a")---身上纠缠着黑色影子动画特效
    --inst inst.AnimState:OverrideSymbol("hips", "swap_whip", "a")---身上纠缠着黑色影子动画特效

    --inst inst.AnimState:OverrideSymbol("leg_low", "swap_whip", "a")---身上纠缠着黑色影子动画特效
    --inst inst.AnimState:OverrideSymbol("leg_mid", "swap_whip", "a")---身上纠缠着黑色影子动画特效
    --inst inst.AnimState:OverrideSymbol("leg_up", "swap_whip", "a")---身上纠缠着黑色影子动画特效
    --inst inst.AnimState:OverrideSymbol("neck", "swap_whip", "a")---身上纠缠着黑色影子动画特效
    --inst inst.AnimState:OverrideSymbol("leg_up", "swap_whip", "a")---身上纠缠着黑色影子动画特效
     --instinst.AnimState:OverrideSymbol("spring", "swap_whip", "a")    ---身上纠缠着黑色影子动画特效
	---身上纠缠着黑色影子动画特效 已经屏蔽
    --inst.Transform:SetScale(2, 2, 2)   

    inst.entity:SetPristine()
	
    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    return inst
end

return Prefab("super_atk_fx", fx1, assets)  --c_spawn"super_atk_fx".entity:SetParent(ThePlayer.entity) 