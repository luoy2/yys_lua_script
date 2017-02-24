function enter_main_function()
  local current_state = check_current_state()
  if current_state == 1 then
	elseif curren_state == 'machi' then
		tap(1550, 572)
		mSleep(1000)
		return enter_main_function()
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
	

-----------------------------------------------------召唤--------------------------------------------------
function summon()
 enter_main_function()
 sub_function:case('ss')
 wait_for_state(式神界面)
 mSleep(1000)
 local if_summon_x, _ = findMultiColorInRegionFuzzy(0xff4f4f,"4|7|0xff0a0a,2|15|0xd40000,-11|6|0xd3bfa0,14|7|0xd6b496", 95, 227, 1182, 255, 1213)
 while if_summon_x > -1 do
		my_toast(id, '可以召唤')
		tap(197, 1221)
		wait_for_state(召唤碎片界面)
		my_toast(id, '正在召唤')
		tap(1565, 840)
		wait_for_leaving_state(召唤碎片界面)
		if_summon_x, _ = findMultiColorInRegionFuzzy(0xff4f4f,"4|7|0xff0a0a,2|15|0xd40000,-11|6|0xd3bfa0,14|7|0xd6b496", 95, 227, 1182, 255, 1213)
	end
	my_toast(id, '召唤完成')
	tap(98, 52)
end

		
		-----------------------------------------------------过剧情--------------------------------------------------
function 过剧情()
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
end

-----------------------------------------------------球赞--------------------------------------------------
function zan()
	enter_main_function()
	state_transit(组队, 聊天发送, 1971, 60, true)
	tap(314, 1469)
	mSleep(1000)
	math.randomseed(mTime())
	this_joke = jokes[math.random(1, tablelength(jokes))]
	inputText(this_joke)
	mSleep(1000)
	local send_x, send_y = myFindColor(聊天发送)
	tap(send_x, send_y)
	mSleep(1000)
	local send_x, send_y = myFindColor(聊天发送)
	tap(send_x, send_y)
	enter_main_function()
end
	

------------------------------------------------------百鬼夜行---------------------------------------------------

function enter_machi()

	local current_state = check_current_state()
	if current_state == 'machi' then 
	else 
		enter_main_function()
		tap(783, 597)
		mSleep(1000)
		return enter_machi()
	end
end	

function change_mame_num(input)
	if input < 5 then
		my_swip_2(615, 1458, 463+(input-1)*40, 1458, 20, 30, 15)
	elseif input == 5 then
	else
		my_swip_2(615, 1458, 615+(input-5)*60, 1458, 20, 30, 15)
	end
end

function choose_mosnter_king(start_x, start_y)
	my_toast(id, '容我选个鬼王')
	tap(math.random(0,2)*756+275, 971)
	mSleep(500)
	tap(start_x, start_y)
	if not wait_for_state(红地毯, 5000) then
		return choose_mosnter_king(start_x, start_y)
	end
end


function monster_hunt_once(mame_num)
	local start_x, start_y = myFindColor(百鬼夜行开始)
	choose_mosnter_king(start_x, start_y)
	change_mame_num(mame_num)

	local end_x, end_y = myFindColor(百鬼中)
	local buff_x, buff_y = 0, 0
	local target_x, target_y = 0, 0
	repeat
		if _G.if_detect_buff then
			keepScreen(true)
			for i,v in ipairs(buff_table) do
				end_x, end_y = myFindColor(百鬼中)
				buff_x, buff_y = myFindColor(v)
				while buff_x > -1 do
					my_toast(id, '丢个buff先')
					tap(buff_x-200, buff_y)
					keepScreen(false)
					keepScreen(true)
					buff_x, buff_y = myFindColor(buff_table[i])
				end
			end
			keepScreen(false)
		end
		keepScreen(true)
		target_x, target_y = myFindColor(鬼怪)
		end_x, end_y = myFindColor(百鬼中)
		keepScreen(false)
		if target_x > -1 then
			my_toast(id, '像扔大便一样扔豆子 酸爽!')
			tap(target_x-200, 945)
		end
		end_x, end_y = myFindColor(百鬼中)
	until end_x == -1
	my_toast(id, '一轮结束')
	tap_till_skip(组队, 7, 926)
	tap(925, 386)--百鬼夜行
end



function monster_hunt_all(count_limit, mame_num)
	local current_count = 0
	local start_x, start_y = myFindColor(百鬼夜行开始)
	if current_count >= count_limit then
		my_toast(id, '百鬼完成')
		do return end
	end
	state_transit(百鬼夜行进入界面, 百鬼夜行选择好友, 496, 1038)
	for friend_page_num = 0, 9, 1 do
		local x, y = findMultiColorInRegionFuzzy(0xcbb59c,"0|5|0xcbb59c", 98, 654, 552, 663, 565)
		for friend = 1, 8, 1 do
			tap(百鬼好友[friend][1], 百鬼好友[friend][2])
			--
			my_toast(id, '尝试邀请这个好友')
			wait_for_state(百鬼夜行进入界面)
			tap(1531, 1036)
			mSleep(2000)
			local start_x, start_y = myFindColor(百鬼夜行进入界面)
			while start_x == -1 do
				my_toast(id, '带此好友快乐的丢豆子')
				monster_hunt_once(mame_num)
				current_count = current_count + 1
				my_toast(id, '百鬼进行次数:　'..current_count..'/'..count_limit)
				if current_count >= count_limit then
					my_toast(id, '百鬼完成')
					do return end
				end
				state_transit(百鬼夜行进入界面, 百鬼夜行选择好友, 496, 1038)
				if friend_page_num ~= 0 then
					for curren_page = 0, friend_page_num, 1 do
						my_swip_2(1002, 1075, 1002, 642, 50, 40, 30)
						mSleep(1000)
					end
				end
				tap(百鬼好友[friend][1], 百鬼好友[friend][2])
				wait_for_state(百鬼夜行进入界面)
				tap(1531, 1036)
				mSleep(2000)
				start_x, start_y = myFindColor(百鬼夜行进入界面)
			end
			my_toast(id, '好友已不能百鬼')
			state_transit(百鬼夜行进入界面, 百鬼夜行选择好友, 496, 1038)
		end
		if x > -1 then
			my_toast(id, '到底了')
		else
			my_swip_2(1002, 1075, 1002, 642, 50, 40, 30)
			mSleep(1000)
		end
	end
	my_toast(id, '没有好友可以邀请了, 请明日再来')
end



function main_baigui()
  baigui_ret,baigui_results = showUI("baigui.json")
	if baigui_ret==0 then	
		my_toast(id, "您选择了取消，停止脚本运行")
		lua_exit()
	else
		baigui_times = tonumber(baigui_results['001'])
		mame_num = tonumber(baigui_results['002'])
		if tonumber(baigui_results['003']) == 0 then
			_G.if_detect_buff = true
		else
			_G.if_detect_buff = false
		end
		my_toast(id,'一共百鬼'..baigui_times..'次, 每轮撒豆'..mame_num..'个')
		enter_machi()
		tap(914, 367)
		wait_for_state(百鬼夜行进入界面)
		return monster_hunt_all(baigui_times, mame_num)
	end
end


-----------------------------------------------------附近妖怪--------------------------------------------------
function nearby_monster()
	while true do
	enter_party()
	swip(400, 1250, 400, 600)
	mSleep(200)
	tap(416, 1139)
	my_toast(id, '开始刷附近妖怪')
	refresh()
	end
end
-----------------------------------------------------日常汇总--------------------------------------------------

function sub_richang(richang_results)
		if richang_results['100'] == '0' then
			give_friend_heart()
		elseif richang_results['100'] == '1' then
			buy_toilet_paper()
		elseif richang_results['100'] == '2' then
			main_baigui()
		elseif richang_results['100'] == '3' then
			summon()
		elseif richang_results['100'] == '4' then
			nearby_monster()
		elseif richang_results['100'] == '5' then
			过剧情()
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
		


