for _, v in ipairs({

    "willow_bernie",--小熊伯尼 
    "willow_lighter",--火女能力
   
    "wortox_blink"--恶魔人能力


   

}) do
---  如下代码 执行了上面代码的列表循环 模仿类似modmain.lua里面的载入功能性lua的 类似
	-- TUNING.BEARGER_POWER_KEY = GetModConfigData("bearger_power")---获取默认按键 ---这个是获取了 maininfo里面的代码的configuration_options 参数

---根据我的推算  inst:AddComponent("tool_bearger") 这个意思就是载入 这个文件夹下面的脚本 scripts\components\tool_bearger.lua  震荡波代码 模拟工具熊 
---而下面的这个  inst.components.tool_bearger.意思就是调用 这个脚本里面的函数
--inst:HasTag("kana") then --and inst:HasTag("kana")条件必须名称是kana

    if GetModConfigData(v) then   
        modimport("modmain/abilities/" .. v) ---  如下代码 执行了上面代码的列表循环 模仿类似modmain.lua里面的载入功能性modmain/abilities/目录里面lua的 
    end
end
