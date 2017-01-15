function enter_main_function()
  local current_state = check_current_state()
  if current_state == 1 then
	elseif current_state == 11 then
  elseif current_state == 21 then
    my_toast(id, '正在战斗中！等待完成战斗进入主界面。。')
		end_combat(0)
		mSleep(2000)
		return enter_main_function()
  elseif current_state == 22 then
    my_toast(id, '在探索副本')
    tap(80, 100)												--退出探索本
    mSleep(1000)
    tap(1244, 842)
    mSleep(1000)
    return enter_main_function()
	elseif current_state == 3 then
		my_toast(id, '在探索界面')
		local x, y = myFindColor(顶点退出)
		sysLogLst(x, y)
		tap(x, y)
		mSleep(3000)
		return enter_main_function()
	else
		local redcross_x, redcross_y = myFindColor(右上红叉)
		if redcross_x > -1 then
			tap(redcross_x, redcross_y)
			mSleep(1000)
			return enter_main_function()
		else 
			my_toast(id, '请手动进入主界面！')
			mSleep(2000)
			return enter_main_function()
		end
	end
end
        
        
        
        
        
        
        
        
        
-----------------------------------------------------送心--------------------------------------------------
        
        
function give_friend_heart()
	enter_main_function()
	mSleep(1000)
	sub_function:case('friend')
	mSleep(1000)
	local song_t = 0
	local shou_t = 0
	while song_t < 10 or shou_t < 10 do
		local song_x, song_y = myFindColor(送心)
		local shou_x, shou_y = myFindColor(收心)
		if song_x > -1 and song_t < 10 then
			tap(song_x, song_y)
      song_t = song_t +1
      my_toast(id, '送心'..song_t..'/10')
			mSleep(300)
		elseif shou_x > -1 and shou_t < 10 then
			tap(shou_x, shou_y)
			shou_t = shou_t +1
			my_toast(id, '收心'..shou_t..'/10')
			mSleep(300)
		else
			swip(500, 955, 500, 475)
			mSleep(300)
		end
	end
end

-----------------------------------------------------买厕纸--------------------------------------------------
function buy_toilet_paper()
	enter_main_function()
	mSleep(1000)
	sub_function:case('shop')
	tap(844, 405)
	mSleep(500)
	local xunzhang_num = dialogInput("请输入兑换勋章的个数(或勋章总数)", "0", "确认");
	local target_num = math.floor(xunzhang_num/20)
	local choice = dialogRet("您想要兑换"..xunzhang_num..'个勋章，共计'..target_num..'厕纸。 确定兑换吗？', "确定", "取消", "", 0);
	sysLog(choice)
	if choice == 1 then 
		lua_exit()
	else
		mSleep(1000)
		local counter = 0
		while counter < target_num do
			tap(821, 651)
			mSleep(1000)
			tap(1037, 938)
			mSleep(1000)
			tap(1000, 1052)
			mSleep(1000)
			counter = counter + 1
			my_toast(id, '厕纸兑换'..counter..'/'..target_num)
		end
	end
end
	
-----------------------------------------------------日常汇总--------------------------------------------------

function sub_richang(richang_results)
		if richang_results['100'] == '0' then
			give_friend_heart()
		elseif richang_results['100'] == '1' then
			buy_toilet_paper()
		end
		mSleep(1000)
		end

function main_richang(richang_ret,richang_results)
	if richang_ret==0 then	
		toast("您选择了取消，停止脚本运行")
		lua_exit()
	end
	sysLog(richang_results['101'])
	if richang_results['101'] == '4' then
		sub_richang(richang_results)
		enter_main_function()
		lua_exit()
		--肝狗粮,
	elseif richang_results['101'] == '0' then		
		ts_ret,ts_results = showUI("tansuo.json")
		sub_richang(richang_results)
		return main_tansuo(ts_ret,ts_results)
	elseif richang_results['101'] == '1' then			
		tupo_ret,tupo_results = showUI("tupo.json")
		sub_richang(richang_results)
		return main_tupo(tupo_ret,tupo_results)
	elseif richang_results['101'] == '2' then
		yqfy_ret,yqfy_results = showUI("yqfy.json")
		sub_richang(richang_results)
		return main_yqfy(yqfy_ret,yqfy_results)
	elseif richang_results['101'] == '3' then
		enter_yeyuanhuo()
		yyh_ret,yyh_results = showUI("yeyuanhuo.json")
		sub_richang(richang_results)
		return main_yeyuanhuo(yyh_ret,yyh_results)
	end
end
		
		
		
	
function main_afk()
  悬赏封印_ret,悬赏封印_results = showUI("xsfy.json")
  ts_ret,ts_results = showUI("tansuo.json")
  
  _G.fighttime = tonumber(ts_results['99'])
  _G.skiplines = tonumber(ts_results['100'])
  _G.searchtime = tonumber(ts_results['101'])
  _G.tupo_sep = tonumber(ts_results['102'])
  if _G.tupo_sep ~= 0 then
    tupo_ret,tupo_results = showUI("tupo.json")
  end
  if _G.fighttime == 0 then
    _G.fighttime = 999999
  end
  
  main_xsfy(悬赏封印_ret,悬赏封印_results)
  tansuo(0, _G.tupo_sep)
end	
		
