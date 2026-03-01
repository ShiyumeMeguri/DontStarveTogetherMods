AddPrefabPostInit("bernie_inactive", function(inst)
    if not TheWorld.ismastersim then return end

    inst.components.equippable.restrictedtag = nil
end)

AddPlayerPostInit(function(inst)

 if inst.prefab == "kana" then  -----私有化代码 如下两个代码就可以让其他人无法用这个技能 
		
	inst:AddTag("bernieowner")
    inst:AddTag("pyromaniac")
 end 
 -----私有化代码 如下两个代码就可以让其他人无法用这个技能 
 
	
end)
