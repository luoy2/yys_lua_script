--确认ocr 识别时间不会出错
--突破次数判断  战斗结束后突破次数-1 必须加入recursion 判断

-- 挑战卷： 649,1167,695,1203
-- 勋章数：928,1166,1008,1205
-- 排名： 1598,1164,1705,1206
-- 刷新： 1617,1032,1739,1090
-------------------------------------------------------个人突破------------------------------------------------------------------

function get_star(input_table)
	if if_defeat(input_table) then return 7 end
  for i = 0,5,1 do
    accept_quest()
    x, y = findColorInRegionFuzzy(0xb3a28d, 95, input_table[1]+63*i-2, input_table[2]-2, input_table[1]+63*i+2, input_table[2]+2)
    if x > -1 then
      star = i
      return star
    end
  end
  accept_quest()
  x, y = findColorInRegionFuzzy(0x645a4f, 95, input_table[1]-2, input_table[2]+38, input_table[1]+2, input_table[2]+42)
  if x > -1 then
    return 6   -- 表示打过了
  else 
    return 5
  end
end


function if_defeat(input_table)
	local x, y = findMultiColorInRegionFuzzy(0xaa3333,"8|19|0xab3534,-26|3|0x260803,-2|34|0x3b0b06", 90, input_table[1]+275,input_table[2]-156, input_table[1]+359 , input_table[2]-63)
	if x > -1 then
		return true
	else
		return false
	end
end


function tupo_from_less_star(items)
  local output_table = {}
  local sortedKeys = getKeysSortedByValue(items, function(a, b) return a < b end)
  for _, key in ipairs(sortedKeys) do
		if items[key] < 6 then
			table.insert(output_table, key)
		end
	end
  return output_table
end


function enter_tupo()
  local current_state = check_current_state()
	if current_state == 'tupo' then
		sleepRandomLag(2000)
	elseif current_state == 3 then
		tap(676, 1457)
		mSleep(200)
		tap(676, 1457)
		sleepRandomLag(2000)
		return enter_tupo()
	else
		enter_tansuo()
		return enter_tupo()
	end
end


function tupo(refresh_count, total_avaliable)
  sysLog(refresh_count..'次刷新')
  if total_avaliable == 0 then
    my_toast(id, "没有挑战卷")
		do return end
  end  
  star_list = {true, true, true,true, true, true,true, true, true}
  keepScreen(true)
  for i = 1,9,1 do
		local this_star = get_star(all_enemy[i])
    star_list[i] = this_star
    sysLog('结界'..i..'勋章: ' .. this_star)
    my_toast(id,'结界'..i..'勋章: ' .. this_star)
  end
  keepScreen(false)	
	tupo_order = tupo_from_less_star(star_list)
	printTable(tupo_order)

	local max_time = tablelength(tupo_order)
	sysLog('此轮突破总次数'..max_time)
  local refresh_state = true
  local j = 1  --从第一次开始
  while refresh_state do
    accept_quest()
    if refresh_count == 3	then
      ifrefresh_x, ifrefresh_y = findColorInRegionFuzzy(0x343956, 95, 824, 1081, 829, 1090) --3次前面的灰色进度条  
    elseif refresh_count == 6 then
      ifrefresh_x, ifrefresh_y = findColorInRegionFuzzy(0x343956, 95, 1120,1083,1130,1092)  -- 6次前面的灰色进度条
    else
      ifrefresh_x = 1
    end
    sysLog('tupo state: '..ifrefresh_x)
    if ifrefresh_x == -1 or j == max_time+1 then
      sysLog(refresh_count..'次已打完')
      my_toast(id,refresh_count..'次已打完')
      tap(690, 270)
      sleepRandomLag(2000)
      tap(690, 270)
      refresh_state = false
    else
      sysLog('开始突破'..tupo_order[j])
      tap(all_enemy[tupo_order[j]][1], all_enemy[tupo_order[j]][2])
      sleepRandomLag(1000)
      tap(all_enemy[tupo_order[j]][1]+187, all_enemy[tupo_order[j]][2]+131)
      sleepRandomLag(1000)
      start_combat(0)
			sleepRandomLag(3000)
			tap(690, 270)
      sleepRandomLag(2000)
      tap(690, 270)
      sysLog('本轮已战斗'..j..'次...')
      my_toast(id,'本轮已战斗'..j..'次...')
      j = j + 1
      total_avaliable = total_avaliable -1
      sysLog('挑战卷: '..total_avaliable)
      if total_avaliable == 0 then
        my_toast(id, "已打完挑战卷！")
				do return end
        --lockDevice();
        --lua_exit();
      end
    end
  end
  sleepRandomLag(2000)
  accept_quest()
  x, y = findColorInRegionFuzzy(0xf3b25e, 95, 1585, 1051, 1595, 1066)  --刷新黄色
  if x == -1 then
    accept_quest()
    waiting_orc = ocrText(dict, 1674,1036,1789,1081, {"0x37332e-0x505050"}, 95, 1, 1) 
    for k,v in pairs(waiting_orc) do
      sysLog(string.format('{x=%d, y=%d, text=%s}', v.x, v.y, v.text))
    end
    minutes = tonumber(waiting_orc[1].text)*10 + tonumber(waiting_orc[2].text)
    seconds = tonumber(waiting_orc[3].text)*10 + tonumber(waiting_orc[4].text) + 0.5
    microseconds = (minutes*60+seconds)*1000
    my_toast(id, '等待'..minutes..'分'..seconds..'秒...')
    sysLog('need to wait '..minutes..' minutes and '..seconds..' seconds('..microseconds..' microseconds)')
    mSleep(microseconds + math.random(1000, 3000))
  end
  tap(1700, 1070)  --点击刷新
  sleepRandomLag(1000)
  tap(1230, 885) --点击确定
  sleepRandomLag(2000)
  tupo(refresh_count, total_avaliable)
end


function main_tupo(tupo_ret,tupo_results)
  if tupo_ret==0 then	
    toast("您选择了取消，停止脚本运行")
    lua_exit()
  end
  enter_tupo()
  accept_quest()
  local tupo_avaliable_ocr = ocrText(dict, 650,1166,696,1203, {"0x37332e-0x505050"}, 95, 1, 1) -- 表示范围内横向搜索，以table形式返回识别到的所有结果及其坐标
  local tupo_avaliable = 0
  for k,v in pairs(tupo_avaliable_ocr) do
    sysLog(string.format('{x=%d, y=%d, text=%s}', v.x, v.y, v.text))
    tupo_avaliable = tupo_avaliable*10 + tonumber(v.text)
  end
  my_toast(id, '挑战卷个数: '..tupo_avaliable)
  sysLog('挑战卷个数: '..tupo_avaliable)		
  if tupo_results['100'] == '0' then
    tupo(3, tupo_avaliable)
  elseif tupo_results['100'] == '1' then
    tupo(6, tupo_avaliable)
  else
    tupo(9, tupo_avaliable)
  end
end



-------------------------------------------------------寮突破------------------------------------------------------------------


function enter_liaotupo()
  local current_state = check_current_state()
	if current_state == 'tupo' then
		sleepRandomLag(1000)
		tap(1978, 742)
		local liao_tupo_x, liao_tupo_y = findMultiColorInRegionFuzzy(0xf8f2de,"0|5|0x7b471e,0|-5|0x74431a", 95, 1943, 651, 1972, 665)
		sysLog(liao_tupo_x)
		while liao_tupo_x == -1 do
			sysLog('未进入寮突破')
			tap(1978, 742)
			mSleep(1000)
			liao_tupo_x, liao_tupo_y = findMultiColorInRegionFuzzy(0xf8f2de,"0|5|0x7b471e,0|-5|0x74431a", 95, 1943, 651, 1972, 665)
		end
	elseif current_state == 3 then
		tap(676, 1457)
		mSleep(200)
		tap(676, 1457)
		sleepRandomLag(2000)
		return enter_liaotupo()
	else
		enter_tansuo()
		return enter_liaotupo()
	end
end


function find_one_round_metal()
	star_list = {true, true, true,true, true, true,true, true}
  keepScreen(true)
  for i = 1,8,1 do
		local this_star = get_star(liao_enemy[i])
    star_list[i] = this_star
    sysLog('结界'..i..'勋章: ' .. this_star)
    my_toast(id,'结界'..i..'勋章: ' .. this_star)
  end
  keepScreen(false)
	return star_list
end


function one_liaotupo(base_metal)
	local this_star_list = find_one_round_metal()
	local search_state = true
	while search_state do
		for tupo_target = 1, 8, 1 do
			if this_star_list[tupo_target] <= base_metal then
				sysLog('找到目标'..tupo_target..', 勋章数'..this_star_list[tupo_target])
				search_state = false
				tap(liao_enemy[tupo_target][1], liao_enemy[tupo_target][2])
				sleepRandomLag(1000)
				tap(liao_enemy[tupo_target][1]+187, liao_enemy[tupo_target][2]+131)
				sleepRandomLag(1000)
				start_combat(0)
				do return end
			end
		end
		my_swip(1305, 1236, 1305, 476, 20)
		mSleep(2000)
		this_star_list = find_one_round_metal()
	end
end


function start_liaotupo(base_metal)
	enter_liaotupo()
	liao_list = {{478, 463}, {488, 745}, {538, 1100}}
	for i = 1, 3, 1 do
		tap(liao_list[i][1], liao_list[i][2])
		mSleep(1000)
		tap(liao_list[i][1], liao_list[i][2])
		mSleep(2000)
		one_liaotupo(base_metal)
		mSleep(2000)
	end
end


function main_liaotupo(mode)
	while true do
		sysLog(_G.time_pass)
		if _G.time_pass <= 10*60*1000 then
			local wait_time = 10*60*1000 - _G.time_pass
			sysLog('等待'..wait_time..'毫秒')
			if mode == 'pure' then
				mSleep(wait_time)
			else
				do return end
			end
		end
			sysLog('可以开始突破')
			_G.liaotupo_t = mTime()
			start_liaotupo(4)
			_G.time_pass = mTime() - _G.liaotupo_t
	end
end