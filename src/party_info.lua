join_party = switch {
  [1] = function () tap(1700,630) end, --加入队伍1
  [2] = function () tap(1700,790) end,	--加入队伍2
  [3] = function () tap(1700,960) end,	--加入队伍3
  [4] = function ()	tap(1700,1120) end	--加入队伍4
}


-----------------------------------------------------------------------------------------------------------
function party_statue()
	local ifstart_x, ifstart_y = myFindColor(组队开始)
	local ifwait_x, if_wait_y = myFindColor(组队等待)
	if ifstart_x > -1 then 
		sysLog('可以开始队伍')
		return 0
	elseif ifwait_x > -1 then
		sysLog('等待队伍开始')
		return 1
	else
		sysLog('已退出界面')
		return 2
	end
end





function enter_party()
  local current_state = check_current_state()
  if current_state == 'party' then
  else
    enter_main_function()
		mSleep(500)
		sub_function:case('party')
		mSleep(1000)
		return enter_party()
	end
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
			in_party()
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

------------------------------------------------------妖气封印--------------------------------------------------------
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
	keepScreen(true)
	for i = 1,4,1 do
		local x, y = yqfyFindColor(input_ss, yqfy_ocr_table[i])
		if x > -1 then
			sysLog(i)
			return(i)
		end
	end
	keepScreen(false)
end
  
  
function refresh_yaoqi(input_ss_table)
	tap(1200, 1300)
	sleepRandomLag(500)
	accept_quest()
	for k,v in pairs(input_ss_table) do
		local slot = find_yaoqi(v)
		if slot ~= nil then
			join_party:case(slot)
			if_outof_sushi()
			sleepRandomLag(1000)
			accept_quest()
			keepScreen(false)
			
			local refresh_x, refresh_y = myFindColor(组队刷新)  --刷新黄色 如果未找到说明在队伍
			sysLog(refresh_x)
			if refresh_x == -1 then
				my_toast(id, "已加入队伍")
				mSleep(1000)
				in_party()
				start_combat(0)
				return true
			else
				sleepRandomLag(200)
				return refresh_yaoqi(input_ss_table)
			end
			
		end
	end
	sleepRandomLag(200)
	return refresh_yaoqi(input_ss_table)
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
				enter_party()
				tap(400, 1230)
				my_toast(id, '开始刷碎片!')
				mSleep(500)
				refresh_yaoqi(ss_target_table)
				current_ss_time = current_ss_time + 1
				sysLog('刷怪次数： '..current_ss_time..' 总次数： '..fight_times)
			end
    end
  end