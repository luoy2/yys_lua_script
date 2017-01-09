function get_lag(result)
	hours = tonumber(results[1].text)*10 + tonumber(results[2].text)
	minutes = tonumber(results[3].text)*10 + tonumber(results[4].text) + 0.5
	microseconds = (hours*60+minutes)*60*1000
	sysLog('need to wait '..hours..' hours and '..minutes..' minutes('..microseconds..' microseconds)')
	return microseconds
end
	--[[
local dict = createOcrDict("dict.txt") 
results = ocrText(dict, 1735,952,1818,985, {"0x37332e-0x505050"}, 95, 1, 1) -- 表示范围内横向搜索，以table形式返回识别到的所有结果及其坐标
--]]






function xu_che()
	x, y = findMultiColorInRegionFuzzy(0x8f5ea0,"-45|-4|0xbdb5a4,-38|45|0xf8f3e0,59|17|0x603d3a", 90, 434,1413, 438, 1417)
	if x ~= -1 and y ~= -1 then        --忽略背景色白色的情况下找到符合条件的图片则点击
		tap(622, 1408)
		sleepRandomLag(3000)										--进入阴阳寮
		tap(1549, 1220)
		sleepRandomLag(3000)									
		tap(1050, 700)			                     --点开结界
		sleepRandomLag(3000)	
		
		accept_quest()
		x, y = findColorInRegionFuzzy(0x272420, 95, 1798, 874, 1802, 876)	 --寄养的黑色+号
		if x > -1 then
			tap(1800, 875)														--点击寄存
			sleepRandomLag(2000)	
			tap(777,712)															--点击好友
			sleepRandomLag(3000)	
			tap(1052,353)													--点击寄存
			sleepRandomLag(3000)
			tap(110, 1420)  												--点开全部式神
			sleepRandomLag(500)
			tap(351, 1180) 												-- 选择sr
			sleepRandomLag(1000)
			swip(1482, 1348, 1800, 600)  			--拖动桃花妖进入寄存
			sleepRandomLag(1000)
			tap(1200, 1030)												-- 点击确认
			sleepRandomLag(1000)
			tap(70, 70)														-- 退出界面
			sleepRandomLag(1000)
			tap(70, 70)
			sleepRandomLag(3000)
			tap(1846, 308)
			toast('开始等待6小时')
			mSleep(6*3600*1000)
			xu_che()
		else
			accept_quest()
			results = ocrText(dict, 1735,952,1818,985, {"0x37332e-0x505050"}, 95, 1, 1)
			waiting_time = get_lag(results)
			tap(70, 70)
			sleepRandomLag(1000)
			tap(70, 70)
			sleepRandomLag(3000)
			tap(1846, 308)
			mSleep(waiting_time)
			xu_che()
		end
	else                               --如果没找到符合条件的
		dialog("请进入主界面 ╮（╯▽╰）╭",0);
	end
end


--[[
for k,v in pairs(results) do
  sysLog(string.format('{x=%d, y=%d, text=%s}', v.x, v.y, v.text))
end
--]]