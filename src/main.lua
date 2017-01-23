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
		_G.friend_quest_action = results['01']
		if _G.friend_quest_action == '0' then
			my_toast(id, '接受悬赏: 是')
		else
			my_toast(id, '接受悬赏: 否')
		end
		sysLog('接受悬赏状态: '.._G.friend_quest_action)
		
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
      xuche_ret, xuche_results = showUI("xuche.json")
			main_xuche(xuche_ret, xuche_results)
      -------------------------------------------探索--------------------------------------
    elseif results['100'] == '4' then
      ts_ret,ts_results = showUI("free_tansuo.json")
      main_freets(ts_ret, ts_results)
      
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
    elseif results['100'] == '9' then
      dialog('功能马上完成, 敬请期待')
      -------------------------------------------开发中--------------------------------------	
		elseif results['100'] == '8' then
			--zyts_ret,zyts_results = showUI("free_tansuo.json")
      --main_freets(zyts_ret, zyts_results)
    else 
      toast("您什么都没有设置")
      lua_exit()
    end
    my_exist(true)
  end
end

--main()
while true do
	keepScreen(true)
	local conver_x, conver_y = myFindColor(对话)
	local combat_x, combat_y = myFindColor(战斗图标)
	local 快进_x, 快进_y = myFindColor(快进)
	local skip_x, skip_y = myFindColor({0xa0998a,"-52|6|0x4f35dd,76|2|0x144ca1",90,1339,1218,1512,1278})
	local 声优_x, 声优_y = myFindColor(声优)
	keepScreen(false)
	sysLog(conver_x..conver_y..combat_x..快进_x..声优_x)
	if 快进_x > -1 then
		tap(快进_x, 快进_y)
	elseif conver_x > -1 then 
		tap(conver_x, conver_y)
		elseif skip_x > -1 or 声优_x >-1 then
		tap(1434, 1245)
	elseif combat_x > -1 then
		tap(combat_x, combat_y)
		start_combat(0)
	end
	mSleep(300)
end