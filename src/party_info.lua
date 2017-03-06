join_party = switch {
  [1] = function () tap(1700,630) end, --加入队伍1
  [2] = function () tap(1700,790) end,	--加入队伍2
  [3] = function () tap(1700,960) end,	--加入队伍3
  [4] = function ()	tap(1700,1120) end	--加入队伍4
}


-----------------------------------------------------------------------------------------------------------
function party_statue()
	keepScreen(true)
	local ifstart_x, ifstart_y = myFindColor(可以开始)				--开始队伍的颜色
	local ifwait_x, if_wait_y = myFindColor(组队等待)
	local leader_wait_x, leader_wait_y = myFindColor(队长等待)
	local refresh_x, refresh_y = findColorInRegionFuzzy(0xf3b25e, 95, 1091, 1272, 1108, 1283)
  local full_color, y_full = myFindColor(三人满)							--三人的右上角
	local full_color_2, y_full_2 = myFindColor(二人满)			
	keepScreen(false)
	if ifstart_x > -1 and full_color == -1 and full_color_2 == -1 then
		sysLog('三人满')
		--my_toast(id, '三人满')
		return 5
	elseif ifstart_x > -1 then 
		sysLog('可以开始队伍')
		--my_toast(id, '可以开始队伍')
		return 0
	elseif leader_wait_x > -1 then
		sysLog('等待人来')
		--my_toast(id, '等待人来')
		return 2
	elseif refresh_x > -1 then
		sysLog('可以刷新')
		--my_toast(id, '可以刷新')
		return 3
	elseif ifwait_x > -1 then
		sysLog('等待队伍开始')
		--my_toast(id, '等待队伍开始')
		return 1
	else
		sysLog('离开组队界面')
		my_toast(id, '离开队伍页面')
		return 4
	end
end


function in_party(case, input_ss_table)
	mSleep(500)
	local statue = party_statue()
	sysLog('队伍状态: '..statue)
	while statue == 1 do
			mSleep(500)
			--my_toast(id, '等待队伍开始')
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
		mSleep(2000)
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
		my_toast(id, '组队界面')
		my_swip(411, 547, 647, 1035, 30)
		mSleep(200)
	elseif current_state == 1 or current_state == 'machi' then
		sub_function:case('party')
		return enter_party()
  else
    enter_main_function()
		wait_for_state(组队)
		sub_function:case('party')
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
	wait_for_state(组队刷新)
	tap(1200, 1300)
	wait_for_state(组队刷新)
	keepScreen(true)
	local x, y = findColorInRegionFuzzy(0xe2c36d, 95, 1615, 594, 1623, 607) --找色是否有队伍
	keepScreen(false)
	if x > -1 then
		join_party:case(1)
		sleepRandomLag(1000)
		accept_quest()
		keepScreen(true)
		local x, y = findColorInRegionFuzzy(0xf3b25e, 95, 1091, 1272, 1108, 1283)  --刷新黄色 如果未找到说明在队伍
		keepScreen(false)
		if x == -1 then
			toast("已加入队伍")
			in_party('shiju', {0})
			return start_combat(0)
		else
			wait_for_state(组队刷新)
			return refresh()
		end
	else
		return refresh()
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
function random_event()
	random_num = math.random(1, 1000)
	sysLog('随机事件:'..random_num)
	if random_num <= 100 then
		my_toast(id, '监测式神召唤')
		summon()
	elseif random_num <= 200 then
		local waiting_time = math.random(60000, 120000)
		waiting_clock(waiting_time)
	elseif random_num == 1000 then
		my_toast(id, '讲个笑话')
		zan()
	end
end
	
	
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
		mSleep(_G.refresh_lag)
		wait_for_state(组队刷新)
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
			sysLog('尝试进入队伍')
			wait_for_leaving_state(刷新等待)
			mSleep(500)
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
				return if_refresh(input_ss_table)
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
		mSleep(3000)
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
	_G.refresh_lag = tonumber(yqfy_results['99'])*100
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
	
	_G.if_liaotupolist = {true, true, true}
	_G.liaotupo_t = 10
  _G.time_pass = mTime() - _G.liaotupo_t
	
	if yqfy_results['01'] == '0' then
    _G.if_random = true
    _G.if_liaotupo = false
  elseif yqfy_results['01'] == '1' then
    _G.if_random = false
    _G.if_liaotupo = true
  elseif yqfy_results['01'] == '0@1' then
    _G.if_random = true
    _G.if_liaotupo = true
  else
    _G.if_random = false
    _G.if_liaotupo = false
  end
  sysLogLst(tostring(_G.if_random), tostring(_G.if_liaotupo))
	
	if _G.if_liaotupo then
    tupo_ret,tupo_results = showUI("tupo.json")
    if tupo_ret==0 then	
      toast("突破未设置, 请从探索页面选择取消突破")
      lua_exit()
    end
  end
	
	while current_ss_time < fight_times do
	  if _G.if_liaotupo then
			_G.time_pass = mTime() - _G.liaotupo_t
			my_toast(id, '已过去时间'.._G.time_pass)
			my_toast(id, '突破保底'..tonumber(tupo_results['200']))
			main_liaotupo('combine', tonumber(tupo_results['200']))
		end
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
		my_toast(id, '进入随机事件')
		random_event()
	end
end



	------------------------------------------------------觉醒--------------------------------------------------------
function juexing(juexing_floor)
		enter_party()
		local this_awaken = math.random(1, 4)
		if _G.jx_type ~= 0 then
			this_awaken = _G.jx_type
		end
		tap(觉醒位置[this_awaken][1], 觉醒位置[this_awaken][2])
		wait_for_state(组队刷新)
		if juexing_floor ~= 0 then
			choose_yuhun_floor(juexing_floor)
		end
		wait_for_state(组队刷新)
		tap(1462, 639)
		wait_for_state(组队刷新)
		return refresh()
end

function if_accept_invite(combat_result, total_fight_times)
	wait_for_state(组队)
	if combat_result == 'win' then
		my_toast(id, '等待15秒内邀请')
		local limit_seconds = 15000
		local qTime = mTime()
		while (mTime() - qTime) <= limit_seconds do
			mSleep(10)
			my_toast(id, '等待邀请: '..string.format("%.2d:%.2d", 0, (limit_seconds - mTime() + qTime)/1000))
			invite_x, invite_y = findColorInRegionFuzzy(0x52ae5d, 95, 215, 409, 229, 417)
			if invite_x ~= -1 then
				my_toast(id, '接受邀请')
				tap(invite_x, invite_y)
				mSleep(1000)
				invite_x, invite_y = findColorInRegionFuzzy(0x52ae5d, 95, 215, 409, 229, 417)
				if invite_x ~= -1 then
					tap(invite_x, invite_y)
				end
				in_party('shiju', {0})
				combat_result = start_combat(0)
				_G.fight_times = _G.fight_times + 1
				my_toast(id, '战斗次数 '.._G.fight_times..'/'..total_fight_times)
				if _G.fight_times < total_fight_times then
					return if_accept_invite(combat_result, total_fight_times)
				else
				end
			end
		end
		my_toast(id, '邀请超时, 自行加入')
	else
		my_toast(id, '战斗失败, 重新加入')
	end
end

function juexing_all()
	while _G.fight_times < _G.jx_times do
		my_toast(id, '战斗次数 '.._G.fight_times..'/'.._G.jx_times)
	  local combat_result = juexing(_G.jx_floor)
		_G.fight_times = _G.fight_times + 1
		if_accept_invite(combat_result, _G.jx_times)
	end
end

function main_jx(jx_ret,jx_results)
	if jx_ret==0 then	
		toast("您选择了取消，停止脚本运行")
		lua_exit()
	end
	_G.jx_times = tonumber(jx_results['100'])
	_G.jx_type = tonumber(jx_results['101'])
	_G.jx_floor = tonumber(jx_results['102'])
	_G.fight_times = 0
	
	if _G.jx_times == 0 then
		_G.jx_times = 99999999
	end
	juexing_all()

end