-------------------------------------------回目检测--------------------------------------
















-------------------------------------------急速（需要修复）--------------------------------------
function recursive_task()
  accept_quest()
  start_color, y_1 = findColorInRegionFuzzy(0xf3b25e, 95, 1457, 1121, 1511, 1128)
  full_color, y_full = findColorInRegionFuzzy(0xf6eee2, 95, 1599, 777, 1622, 782)
  if start_color > -1 then
    toast ("开始队伍")
    tap(1547, 1157)
    mSleep(200)
    ready()
    toast ("点击准备")
    while true do
      accept_quest()
      invite_color_1, y_2 = findColorInRegionFuzzy(0xdf6851, 95, 897, 876, 937, 897)
      invite_color_2, y_3 = findColorInRegionFuzzy(0xf3b25e, 95, 1107, 870, 1133, 887)
      if invite_color_1 > -1 and invite_color_2 > -1 then
        toast ("重新邀请")
        tap(1184, 877)
        mSleep(1000)
        recursive_task()
      else
        first_mark()
      end
    end
  else
    mSleep(1000)
    toast ("尝试开始队伍")
    return recursive_task()
  end
end
-------------------------------------------单刷--------------------------------------
function solo_yh(mark_case)
  current_state = check_current_state()
	if current_state == 3 then
  else
		enter_tansuo()
	end
	mSleep(1000)
	local tansuo_x, tansuo_y = findColorInRegionFuzzy(0x1e1ea6, 95, 314, 1493, 340, 1509) -- 探索yuhun下方蓝色
	while tansuo_x > -1 do
		tap(326, 1454)
		mSleep(1000)
		accept_quest()
		tansuo_x, tansuo_y = findColorInRegionFuzzy(0x1e1ea6, 95, 314, 1493, 340, 1509) -- 探索yuhun下方蓝色
	end
	mSleep(1000)
	tap(600, 800)
  mSleep(1000)
  swip(650, 830, 650, 450)
  swip(650, 830, 650, 450)
  swip(650, 830, 650, 450)
  tap(627, 810)
  mSleep(1000)
  tap(1540, 990)
  return custom_mark_combat(mark_case)
end








-------------------------------------------队长--------------------------------------
function team_leader(mark_case, member_number)
  accept_quest()
  local start_color, y_1 = findMultiColorInRegionFuzzy(0xf3b25e,"-1079|-3|0xdf6851,-436|33|0xc7bdb4,-129|-13|0x973b2e", 95, 1560,1120,1565,1130)					--开始队伍的颜色
  local full_color, y_full = findColorInRegionFuzzy(0xf5eddf, 95, 1609, 777, 1615, 782)					--三人的加号 如果找不到就开
  if member_number == 3 then
    if start_color > -1 and full_color == -1 then
      toast ("开始队伍")
      tap(1547, 1157)
			if_outof_sushi()
      custom_mark_combat(mark_case)
      sleepRandomLag(1000)
      while true do
        accept_quest()
        invite_color_1, y_2 = findColorInRegionFuzzy(0xdf6851, 95, 897, 876, 937, 897)
        invite_color_2, y_3 = findColorInRegionFuzzy(0xf3b25e, 95, 1107, 870, 1133, 887)
        if invite_color_1 > -1 and invite_color_2 > -1 then
          my_toast(id,"重新邀请")
          tap(1184, 877)
          mSleep(2000)
          break end
          sleepRandomLag(1000)
        end
      else
        sleepRandomLag(3000)
        my_toast(id,'等待队友加入')
        team_leader(mark_case, member_number)
      end
	else
		if start_color > -1 then
			my_toast(id, "开始队伍")
			tap(1547, 1157)
			if_outof_sushi()
			custom_mark_combat(mark_case)
			sleepRandomLag(1000)
			while true do
				accept_quest()
				invite_color_1, y_2 = findColorInRegionFuzzy(0xdf6851, 95, 897, 876, 937, 897)
				invite_color_2, y_3 = findColorInRegionFuzzy(0xf3b25e, 95, 1107, 870, 1133, 887)
				if invite_color_1 > -1 and invite_color_2 > -1 then
					toast ("重新邀请")
					tap(1184, 877)
					mSleep(2000)
				break end
					sleepRandomLag(1000)
			end
		else
				sleepRandomLag(3000)
				my_toast(id,'等待队友加入')
				return team_leader(mark_case, member_number)
		end
	end
end
    
    
    
    
    
    
    
    
    -------------------------------------------队员接受邀请--------------------------------------
function accept_invite(mark_case)
	accept_quest()
	local invite_col, y_1 = findColorInRegionFuzzy(0x52ae5d, 95, 215, 409, 229, 417)
	if invite_col > -1 then
		tap(invite_col, y_1)
		if_outof_sushi()
		my_toast(id,"接受邀请")
		sleepRandomLag(3000)
		return custom_mark_combat(mark_case)
	else
		sleepRandomLag(2000)
		my_toast(id,'等待邀请')
		return accept_invite(mark_case)
	end
end
    
    
    
    
    -------------------------------------------yh标记设置--------------------------------------
function custom_mark_combat(mark_array)
	--sysLog('custom_mark_combat')
	accept_quest()
	ready()
	mSleep(1000)
	round = 1
	while round <= 2 do
		if_mark(mark_array[round])
		if_other_round()
		round = round + 1
		mSleep(1000)
	end
	if_mark(mark_array[round])
	return end_combat(0)
end
    
    
function if_other_round()
	--sysLog('if_other_round')
	x, y = findMultiColorInRegionFuzzy(0x272420,"0|13|0xe6cca0,2|-15|0x272420", 95, 1027-2,794-2,1027+2,794+2)
	--x, y = findMultiColorInRegionFuzzy(0x691007,"16|-32|0x2d2720,-8|-85|0xf3daa9,15|-198|0x272420", 85, 1034-5,991-5, 1034+5,991+5) --回目
	if x > -1 then
		--my_toast(id,'检测到回目')
	else
		my_toast(id,'等待下一回合的标记')
		mSleep(20)
		if_other_round()
	end
end
    
    
    --标记二口女
function first_mark()
	sysLog('first_mark')
	accept_quest()
	local blueball_x, blueball_y = findColorInRegionFuzzy(0x9cffee, 95, 475, 518, 593, 545)
	if blueball_x > -1 then
		tap(529, 488)
		accept_quest()
		local mark_x, mark_y = findMultiColorInRegionFuzzy(0xf9936a,"-2|-4|0xfb826a,7|-4|0xfe8966,-10|-4|0xff9863", 95, 439,313,677,516)
		while mark_x == -1 do
			tap(529, 488)
			mark_x, mark_y = findMultiColorInRegionFuzzy(0xf9936a,"-2|-4|0xfb826a,7|-4|0xfe8966,-10|-4|0xff9863", 95, 439,313,677,516)
		end
		--my_toast(id,'检测到标记')
		first_mark()
		my_toast(id, "已标记二口女")
	else
		tap(1076, 397)
		accept_quest()
		local mark_x, mark_y = findMultiColorInRegionFuzzy(0xf9936a,"-2|-4|0xfb826a,7|-4|0xfe8966,-10|-4|0xff9863", 95, 997,295,1136,410)
		while mark_x == -1 do
			tap(1076, 397)
			mark_x, mark_y = findMultiColorInRegionFuzzy(0xf9936a,"-2|-4|0xfb826a,7|-4|0xfe8966,-10|-4|0xff9863", 95, 703,7,1772,645)
		end
		--my_toast(id,'检测到标记')
		my_toast(id, "已标记中间！")
	end
end
    
    
    -------------------------------------------御魂汇总--------------------------------------
function main_yh(yh_ret, yh_results)
	if yh_ret==0 then	
		toast("您选择了取消，停止脚本运行")
		lua_exit()
	end
	--------------------------------队长2人---------------------------------
	mark_1 = tonumber(yh_results['201']) + 2
	mark_2 = tonumber(yh_results['202']) + 2
	mark_3 = tonumber(yh_results['203']) + 2
	if mark_2 == 5 then mark_2 = 6 end
	if mark_3 == 5 then mark_3 = 6 end
	mark_case = {mark_1, mark_2, mark_3}
	--printTable(mark_case)
	if yh_results["101"]== "0" then
		toast("开始魂10自动战斗，请进入组队界面后创建队伍，邀请基友"); 
		mSleep(2000)
		while true do 
			team_leader(mark_case, 2)
		end
		--------------------------------队长3人---------------------------------
	elseif yh_results["101"] == "1" then
		toast("开始魂10自动战斗，请进入组队界面后创建队伍，邀请基友"); 
		mSleep(2000)
		while true do 
			team_leader(mark_case, 3)
		end
		--------------------------------加入队伍--------------------------------
	elseif yh_results['101'] == '2' then
		task = "加入队伍"
		--------------------------------等待邀请---------------------------------
	elseif yh_results["101"] == "3" then
		toast("开始魂10自动战斗，请等待基友邀请"); 
		sleepRandomLag(2000)
		while true do 
			accept_invite(mark_case)
		end
	elseif yh_results["101"] == "4" then
		recursive_task()
	elseif yh_results["101"] == "5" then
		while true do 
			solo_yh(mark_case)
		end
	else
		dialog("你tm什么都没设置，玩儿我吧？")
		lua_exit()
	end
end

    
    
    
    
    
    
    
    
    
    
    
    
    -------------------------------------------业原火--------------------------------------

    
function enter_yeyuanhuo()
	local current_state = check_current_state()
	if current_state == 'yeyuanhuo' then
		my_toast(id, '进入业原火')
		tap(1457, 770)
		mSleep(500)
		return enter_yeyuanhuo()
	elseif current_state == 'yeyuanhuo_challenge' then
		my_toast(id, '选择业原火难度界面')
		return true
	else
		enter_tansuo()
		my_toast(id, '在探索界面')
		tap(334, 1448)
		mSleep(500)
		return enter_yeyuanhuo()
	end
end
    
    
    
function yeyuanhuo(times, difficulty)
	if times == 0 then
		lockDevice()
		mSleep(200)
		lua_exit()
	end
	--sysLog('yeyuanhuo')
	enter_yeyuanhuo()
	--确定进入探索
	accept_quest()
	my_toast(id, '开始挑战业原火')
	choose_yeyuanhuo:case(difficulty)
	mSleep(500)
	tap(1527, 982)
	mSleep(2000)
	results = custom_mark_combat({2,2,3})
	if results == 'win' then
		times = times -1
	end
	return yeyuanhuo(times, difficulty)
end

		
function main_yeyuanhuo(yyh_ret, yyh_results)
	if yyh_ret==0 then	
		toast("您选择了取消，停止脚本运行")
		lua_exit()
	end
	local times = tonumber(yyh_results['100'])
	local difficulty = tonumber(yyh_results['101'])+1
	yeyuanhuo(times, difficulty)
end
    