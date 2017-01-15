join_party = switch {
  [1] = function () tap(1700,630) end, --加入队伍1
  [2] = function () tap(1700,790) end,	--加入队伍2
  [3] = function () tap(1700,960) end,	--加入队伍3
  [4] = function ()	tap(1700,1120) end	--加入队伍4
}


-----------------------------------------------------------------------------------------------------------
function party_statue()
	keepScreen(true)
	local ifstart_x, ifstart_y = findMultiColorInRegionFuzzy(0xf3b25e,"-1079|-3|0xdf6851,-436|33|0xc7bdb4,-129|-13|0x973b2e", 95, 1560,1120,1565,1130)					--开始队伍的颜色
	local ifwait_x, if_wait_y = myFindColor(组队等待)
	local leader_wait_x, leader_wait_y = myFindColor(队长等待)
	local refresh_x, refresh_y = findColorInRegionFuzzy(0xf3b25e, 95, 1091, 1272, 1108, 1283)
  local full_color, y_full = findColorInRegionFuzzy(0x7c7977, 95, 1773, 466, 1803, 493)					--三人的右上角
	local full_color_2, y_full_2 = findColorInRegionFuzzy(0x7c7977, 95, 1225, 468, 1258, 501)			--二人的右上角
	keepScreen(false)
	if ifstart_x > -1 and full_color == -1 and full_color_2 == -1 then
		sysLog('三人满')
		return 5
	elseif ifstart_x > -1 then 
		sysLog('可以开始队伍')
		return 0
	elseif leader_wait_x > -1 then
		sysLog('等待人来')
		return 2
	elseif refresh_x > -1 then
		sysLog('可以刷新')
		return 3
	elseif ifwait_x > -1 then
		sysLog('等待队伍开始')
		return 1
	else
		sysLog('离开组队界面')
		return 4
	end
end


function in_party(case, input_ss_table)
	mSleep(500)
	local statue = party_statue()
	sysLog('队伍状态: '..statue)
	while statue == 1 do
			mSleep(500)
			my_toast(id, '等待队伍开始')
			statue = party_statue()
	end
	if statue == 2 or statue == 0 then
		my_toast(id, '队长离开队伍，离开')
		tap(477,1161)
		mSleep(500)
		local x, y = findMultiColorInRegionFuzzy(0xf3b25e,"-313|19|0xdf6851,-193|25|0xcbb59c", 90, 659, 799, 1376, 948)
		while x == -1 do
			tap(477,1161)
			mSleep(500)
		end
		tap(1230, 883)
		mSleep(500)
		return in_party(case, input_ss_table)
	elseif statue == 3 then
		my_toast(id, '可以刷新')
		mSleep(500)
		if case == 'shiju' then return refresh()
		elseif case == 'yaoqi' then return refresh_yaoqi(input_ss_table)
		end
	elseif statue == 4 then
		mSleep(1000)
	end
	sysLog('final statu')
	statue = party_statue()
	if statue == 4 then
	else 
	sysLog('false alarm') 
	return in_party(case, input_ss_table) end
end


function enter_party()
	sysLog('enter_party')
  local current_state = check_current_state()
  if current_state == 'party' then
		mSleep(500)
		my_swip(411, 547, 647, 1035, 30)
		mSleep(500)
	elseif current_state == 1 or current_state == 'machi' then
		mSleep(500)
		sub_function:case('party')
		mSleep(1000)
		return enter_party()
  else
    enter_main_function()
		mSleep(500)
		sub_function:case('party')
		mSleep(1000)
		return enter_party()
	end
end


function enter_yaoqi()
	enter_party()
	mSleep(500)
	tap(400, 1230)
	my_toast(id, '开始刷碎片!')
	mSleep(1000)
end
  
function refresh()
	tap(1200, 1300)
	sleepRandomLag(500)
	accept_quest()
	x, y = findColorInRegionFuzzy(0xe2c36d, 95, 1615, 594, 1623, 607) --找色是否有队伍
	if x > -1 then
		join_party:case(1)
		sleepRandomLag(500)
		--x, y = findImageInRegionFuzzy("refresh.png", 50, 1143, 1264, 1297, 1331, 0); 
		accept_quest()
		x, y = findColorInRegionFuzzy(0xf3b25e, 95, 1091, 1272, 1108, 1283)  --刷新黄色 如果未找到说明在队伍
		if x == -1 then
			toast("已加入队伍")
			mSleep(1000)
			in_party('shiju', {0})
			start_combat(0)
		else
			sleepRandomLag(200)
			refresh()
		end
	else
		sleepRandomLag(200)
		refresh()
	end
end

------------------------------------------------------石距--------------------------------------------------------
function shiju(time_left)
	if time_left <= 0 then
		sysLog('可以打石距')
		sleepRandomLag(500)
		enter_party()
		swip(400, 1250, 400, 600)
		sleepRandomLag(2000)
		tap(400, 1030)
		refresh()
		_G.time_left = 60*60*1000
	else
		sysLog('等待'.._G.time_left..'毫秒')
	end
end
  
	------------------------------------------------------妖气封印--------------------------------------------------------
function yqfyFindColor(color, position)
	accept_quest()
	local x, y = findMultiColorInRegionFuzzy(color[1], color[2], color[3], position[1], position[2], position[3], position[4])
	return x, y
end
  
	
function find_yaoqi(input_ss)
	--sysLog('find_yaoqi')
	keepScreen(true)
	for i = 1,4,1 do
		local x, y = yqfyFindColor(input_ss, yqfy_ocr_table[i])
		if x > -1 then
			--sysLog(i)
			return(i)
		end
	end
	keepScreen(false)
end


function if_refresh(input_ss_table)
		--sysLog('if_refresh')
	local refresh_x, refresh_y = findColorInRegionFuzzy(0xf3b25e, 95, 1075, 1258, 1348, 1344)
	if refresh_x > -1 then
		sysLog('找到刷新')
		tap(refresh_x, refresh_y)
		--sysLog('是否有妖气')
		mSleep(100)
		return if_monster(input_ss_table)
	else
		sysLog('未找到刷新')
		return seal_yaoqi(input_ss_table)
	end
end


function if_monster(input_ss_table)
	--sysLog('if_monster')
	for k,v in pairs(input_ss_table) do
		local slot = find_yaoqi(v)
		if slot ~= nil then
			join_party:case(slot)
			mSleep(200)
			accept_quest()
			keepScreen(false)
			local refresh_x, refresh_y = myFindColor(组队刷新)  --刷新黄色 如果未找到说明在队伍
			if refresh_x == -1 then
				if_outof_sushi()
				my_toast(id, "已加入队伍")
				--sysLog('加入队伍成功')
				mSleep(2000)
				sysLog('进入队伍, 检测队伍状态...')
				return check_party_statue('yaoqi', ss_target_table)
			else
				mSleep(100)
				sysLog('加入队伍失败')
				return if_monster(input_ss_table)
			end
		end
	end
	sysLog('没找到妖气')
	mSleep(100)
	return if_refresh(input_ss_table)
end


function check_party_statue(case, input_ss_table)
	mSleep(500)
	local statue = party_statue()
	sysLog('队伍状态: '..statue)
	if statue == 1 then
		mSleep(500)
		my_toast(id, '等待队伍开始')
		sysLog('等待队伍开始')
		return check_party_statue(case, input_ss_table)
	elseif statue == 2 or statue == 0 then
		my_toast(id, '队长离开队伍，离开')
		sysLog('离开队伍'..statue)
		tap(477,1161)
		mSleep(500)
		local x, y = findMultiColorInRegionFuzzy(0xf3b25e,"-313|19|0xdf6851,-193|25|0xcbb59c", 90, 659, 799, 1376, 948)
		while x == -1 do
			tap(477,1161)
			mSleep(500)
		end
		tap(1230, 883)
		mSleep(500)
		return if_monster(input_ss_table)
	elseif statue == 3 then
		sysLog('刷新页面'..statue)
		my_toast(id, '可以刷新')
		mSleep(500)
		if case == 'shiju' then 
			return refresh()
		elseif case == 'yaoqi' then 
			return if_monster(input_ss_table)
		end
	elseif statue == 4 then
		sysLog('疑似战斗页面')
		mSleep(1000)
	end
	sysLog('检测最终状态')
	statue = party_statue()
	if statue == 4 then
		sysLog('应该是可以开始战斗了')
		return start_combat(0)
	else 
		sysLog('false alarm') 
		return seal_yaoqi(input_ss_table) end
end


function seal_yaoqi(input_ss_table)
	sysLog('进入妖气...')
	enter_yaoqi()
	return if_refresh(input_ss_table)
	--sysLog(combat_result_inall)
end

  
function main_yqfy(yqfy_ret, yqfy_results)

	if yqfy_ret==0 then	
		toast("您选择了取消，停止脚本运行")
		lua_exit()
	end
	ss_list = {海坊主, 小黑, 二口女, 骨女, 哥哥, 经验, 金币, 椒图, 饿鬼, '石距'}
	sysLogLst(ss_list)
	local fight_times = tonumber(yqfy_results['100'])
	local ss_index = str_split((yqfy_results['101']))														--ui返回选择的项目index
	_G.time_left = tonumber(yqfy_results['102'])*60*1000												--用户输入的石距剩余时间
	local initial_t = mTime()																										--当前时间
	sysLog(_G.time_left)
	--初始化战斗次数
	local current_ss_time = 0
	-- 如果用户选择战斗次数为0则最大化战斗次数
	if fight_times == 0 then
		fight_times = 999999
	end							
	ss_target_table = {}
	--ui返回选择的0_base_index,需要+1才能用在lua table里面
	for k,v in pairs(ss_index) do
		ss_index[k] = ss_index[k] + 1
		table.insert(ss_target_table, ss_list[ss_index[k]])
	end	
	sysLog(tablelength(ss_target_table))
	if table.contains(ss_target_table, '石距') then
		sysLog('需要打章鱼')
		table.remove(ss_target_table, tablelength(ss_target_table))
		if_shiju = true
	end
	
	while current_ss_time < fight_times do
		if if_shiju then
			local pass_time = mTime() - initial_t
			local time_left = _G.time_left - pass_time
			sysLog(time_left)
			shiju(time_left)
			my_toast(id, '等待'..math.ceil(time_left/1000)..'秒可以打石距')
			mSleep(1000)
		end
		if next(ss_target_table) ~= nil then 
			seal_yaoqi(ss_target_table)
			current_ss_time = current_ss_time + 1
			sysLog('刷怪次数： '..current_ss_time..' 总次数： '..fight_times)
		end
	end
end



	------------------------------------------------------觉醒--------------------------------------------------------
function enter_juexing()
end









--[[
function refresh_yaoqi(input_ss_table)
	--sysLog('refresh_yaoqi')
	local refresh_x, refresh_y = myFindColor(组队刷新)
	if refresh_x > -1 then
		tap(refresh_x, refresh_y)
	else
		enter_yaoqi()
		sysLog('没找到..refresh_yaoqi')
		return refresh_yaoqi(input_ss_table)
	end
	mSleep(200)
	accept_quest()
	for k,v in pairs(input_ss_table) do
		local slot = find_yaoqi(v)
		if slot ~= nil then
			join_party:case(slot)
			if_outof_sushi()
			mSleep(200)
			accept_quest()
			keepScreen(false)
			refresh_x, refresh_y = myFindColor(组队刷新)  --刷新黄色 如果未找到说明在队伍
			--sysLog(refresh_x)
			if refresh_x == -1 then
				my_toast(id, "已加入队伍")
				mSleep(2000)
				sysLog('函数跳出')
				do return end
			else
				mSleep(100)
				sysLog('1..refresh_yaoqi(input_ss_table)')
				return refresh_yaoqi(input_ss_table)
			end
		end
	end
	sysLog('2..refresh_yaoqi(input_ss_table)')
	return refresh_yaoqi(input_ss_table)
end
--]]