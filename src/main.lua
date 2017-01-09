--
init("0", 1)
setScreenScale(1536,2048)
width,height = getScreenSize()
sysLog("width: "..width.."; height: "..height)


require "utils"
require "party_info"
require "yuhun_info"
require "inCombat"
require "tansuo"
require "xuche"
require "tupo"
require "spec"
require "richang"
require 'xsfy'
pos = require("bblibs/pos")

dict = createOcrDict("dict.txt") 
id = createHUD()     --创建一个HUD
my_toast(id,"欢迎使用大便脚本！")     --显示HUD内容




function main()
  ret,results = showUI("ui.json")
  if ret==0 then	
    toast("您选择了取消，停止脚本运行")
    lua_exit()
  else
    toast_screensize()
    
    --↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓获取UI配置↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
    -------------------------------------------个人突破--------------------------------------
    if results['100'] == '0' then	
      tupo_ret,tupo_results = showUI("tupo.json")
			return main_tupo(tupo_ret,tupo_results)

      
      -------------------------------------------悬赏封印--------------------------------------
    elseif results['100'] == '1' then
			dialog("功能处于测试版本,请阅读脚本说明以及教程后进行设置,若出现问题请加q群反馈bug")
			悬赏封印_ret,悬赏封印_results = showUI("xsfy.json")
			if 悬赏封印_ret==0 then	
			toast("您选择了取消，停止脚本运行")
			lua_exit()
			end
			if 悬赏封印_results['200'] ~= '0' then
				fengyin_toast = createHUD()
				local fy_monster = tostring(mystery_table[tonumber(悬赏封印_results['200'])][1])
				local location = tostring(mystery_table[tonumber(悬赏封印_results['200'])][2])
				local detail = tostring(mystery_table[tonumber(悬赏封印_results['200'])][3])
				local output_text = '您需要击杀'..fy_monster..", 在"..location..", 具体如下:"..detail
				showHUD(fengyin_toast, output_text,30,"0xffff0000","0xffffffff",0,724,1200,600,80) 
			end
			local skip_lines = tonumber(悬赏封印_results['01'])
			local fy_order_1 = {tonumber(悬赏封印_results['101']), tonumber(悬赏封印_results['100'])}
			local fy_order_2 = {tonumber(悬赏封印_results['111']), tonumber(悬赏封印_results['110'])}
			local fy_order_3 = {tonumber(悬赏封印_results['121']), tonumber(悬赏封印_results['120'])}
			local fy_order_4 = {tonumber(悬赏封印_results['131']), tonumber(悬赏封印_results['130'])}
			local fy_order = {fy_order_1, fy_order_2, fy_order_3, fy_order_4}
			fy_all(fy_order, skip_lines)
			mSleep(30*600000)
			lockDevice()
			lua_exit()

  
      -------------------------------------------御魂10--------------------------------------
    elseif results['100'] == '2' then
      yh_ret,yh_results = showUI("yuhun.json")
			return main_yh(yh_ret,yh_results)
      -------------------------------------------阴阳寮续车--------------------------------------	
    elseif results['100'] == '3' then
      xu_che()
      -------------------------------------------探索--------------------------------------
    elseif results['100'] == '4' then
      ts_ret,ts_results = showUI("tansuo.json")
			return main_tansuo(ts_ret, ts_results)
      
      -------------------------------------------业原火--------------------------------------	
    elseif results['100'] == '5' then
      enter_yeyuanhuo()
      yyh_ret,yyh_results = showUI("yeyuanhuo.json")
			return main_yeyuanhuo(yyh_ret,yyh_results)
      -------------------------------------------妖气封印--------------------------------------	
    elseif results['100'] == '6' then
      yqfy_ret,yqfy_results = showUI("yqfy.json")
			return main_yqfy(yqfy_ret, yqfy_results)
      
      -------------------------------------------日常杂项--------------------------------------	
    elseif results['100'] == '7' then
      richang_ret,richang_results = showUI("richang.json")
			main_richang(richang_ret,richang_results)
      -------------------------------------------开发中--------------------------------------	
    else 
      dialog("你tm什么都没设置，玩儿我吧？")
      lua_exit()
      
    end
  end
  
  
end

function in_party()
	local statue = party_statue()
	while statue == 1 do
			mSleep(500)
			my_toast(id, '等待队伍开始')
			statue = party_statue()
	end
		if statue == 2 then
			my_toast(id, '进入战斗')
			mSleep(500)
		else
			my_toast(id, '队长跑了,自己开始队伍')
			tap(1547, 1157)
			if_outof_sushi()
			sleepRandomLag(1000)
	end
end

main()


--[[
enter_main_function()
my_swip(200, 1250, 1800, 1250, 50)
local feng_x, feng_y = myFindColor(悬赏)
if feng_x > -1 then tap(feng_x, feng_y) else sysLog('couldnt find feng') end
]]--





斗鱼 = {0x3d3934,"0|12|0x34312c,7|-6|0xccc4ba,13|-3|0x33302b,7|6|0x2d2925,12|7|0x58544e,20|5|0x4e4a45,23|9|0x4c4843",90,1245,726,1588,778}
太鼓 = {0x807a73,"6|0|0x3e3a36,4|3|0x494540,0|8|0x625e58,10|7|0x37342f,13|5|0xc9c1b8,19|5|0x36322e,19|0|0x312e29,18|15|0x3b3732,8|-12|0x5a554f",90,1245,726,1588,778}

local d_x, d_y = myFindColor(斗鱼)
local t_x, t_y = myFindColor(太鼓)


------------------------------------------------------------------------------


-----------------------------------------------------------------------------

--[[
find_yaoqi(海坊主)
find_yaoqi(小黑)
find_yaoqi(经验)
find_yaoqi(金币)
find_yaoqi(椒图)
find_yaoqi(二口女)
find_yaoqi(骨女)
find_yaoqi(哥哥)
find_yaoqi(饿鬼)
--snapshot("invite_na.png", 697,693,805,734); --全屏截图（分辨率1080*1920）
--]]

--/User/Library/XXIDEHelper/xsp/Temp/5星.png

--page 2





