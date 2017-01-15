--
--init("0", 1)
setScreenScale(1536,2048)
init("0", 1)


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
      main_tupo(tupo_ret,tupo_results)
      
      -------------------------------------------悬赏封印--------------------------------------
    elseif results['100'] == '1' then
      toast("功能处于测试版本,请阅读脚本说明以及教程后进行设置,若出现问题请加q群反馈bug")
      悬赏封印_ret,悬赏封印_results = showUI("xsfy.json")
      main_xsfy(悬赏封印_ret,悬赏封印_results)
      
      -------------------------------------------御魂10--------------------------------------
    elseif results['100'] == '2' then
      yh_ret,yh_results = showUI("yuhun.json")
      main_yh(yh_ret,yh_results)
      -------------------------------------------阴阳寮续车--------------------------------------	
    elseif results['100'] == '3' then
      xu_che()
      -------------------------------------------探索--------------------------------------
    elseif results['100'] == '4' then
      ts_ret,ts_results = showUI("tansuo.json")
      main_tansuo(ts_ret, ts_results)
      
      -------------------------------------------业原火--------------------------------------	
    elseif results['100'] == '5' then
      enter_yeyuanhuo()
      yyh_ret,yyh_results = showUI("yeyuanhuo.json")
      main_yeyuanhuo(yyh_ret,yyh_results)
      -------------------------------------------妖气封印--------------------------------------	
    elseif results['100'] == '6' then
      yqfy_ret,yqfy_results = showUI("yqfy.json")
      main_yqfy(yqfy_ret, yqfy_results)
      
      -------------------------------------------日常杂项--------------------------------------	
    elseif results['100'] == '7' then
      richang_ret,richang_results = showUI("richang.json")
      main_richang(richang_ret,richang_results)
      -------------------------------------------一条龙挂机--------------------------------------	
    elseif results['100'] == '8' then
      dialog('功能马上完成, 敬请期待')
      -------------------------------------------开发中--------------------------------------	
      
    else 
      toast("您什么都没有设置")
      lua_exit()
    end
    my_exist(true)
  end
end

main()



--]]
--
--check_current_state()
--[[
enter_main_function()
  my_swip(200, 1250, 1800, 1250, 50)
  local feng_x, feng_y = myFindColor(悬赏)
  if feng_x > -1 then tap(feng_x, feng_y) else sysLog('couldnt find feng') end
  ]]--
  
  
  
  --[[
  
  斗鱼 = {0x3d3934,"0|12|0x34312c,7|-6|0xccc4ba,13|-3|0x33302b,7|6|0x2d2925,12|7|0x58544e,20|5|0x4e4a45,23|9|0x4c4843",90,1245,726,1588,778}
  太鼓 = {0x807a73,"6|0|0x3e3a36,4|3|0x494540,0|8|0x625e58,10|7|0x37342f,13|5|0xc9c1b8,19|5|0x36322e,19|0|0x312e29,18|15|0x3b3732,8|-12|0x5a554f",90,1245,726,1588,778}
  
  local d_x, d_y = myFindColor(斗鱼)
  local t_x, t_y = myFindColor(太鼓)
  enter_main_function()
    sub_function:case('guild')
    tap(1549, 1220)
    sleepRandomLag(3000)									
    tap(1050, 700)			                     --点开结界
    sleepRandomLag(3000)	
    
    accept_quest()
    local x, y = findColorInRegionFuzzy(0x272420, 95, 1798, 874, 1802, 876)	 --寄养的黑色+号
    if x > -1 then
      tap(1800, 875)														--点击寄存
      sleepRandomLag(2000)	
      tap(777,712)
    end
    
    
    x, y = myFindColor(不动风车)
    if x > -1 then
      sysLog('没有结界卡')
    end
    --]]
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
    
   