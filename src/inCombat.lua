


-------------------------------------------标记类型a--------------------------------------
mark_cases = switch {
  [0] = function() end,
  [1] = function() tap(1060, 270) end, --标记主目标
	-----yh标记----
	[2] = function() tap(530, 560) end,		--标记左边
	[3] = function() tap(1076, 397) end,  --标记中间(灯，蛇）
	[4] = function() tap(1580, 535)	end,	--标记右边
	[5] = function() first_mark()	end, --标记二口女
	[6] = function() end,　-- 不标记
	----------yyh---------------
}

	
function if_mark(tap_situation)
	if tap_situation ~= 6 and tap_situation ~= 0 then
		--sysLog('if_mark'..tap_situation)
		accept_quest()
		x, y = findMultiColorInRegionFuzzy(0xf9936a,"-2|-4|0xfb826a,7|-4|0xfe8966,-10|-4|0xff9863", 95, 0, 0, 2047, 1535)
		if x > -1 then
			my_toast(id,'为您标记好了')
			mSleep(2000)
		else
			--my_toast(id,'标记case'..tap_situation)
			mark_cases:case(tap_situation)
			mSleep(20)
			return if_mark(tap_situation)
		end
	end
end

-------------------------------------------开始战斗--------------------------------------
function begin()
	accept_quest()
  x, y = findColorInRegionFuzzy(0xf3b25e, 95, 1457, 1121, 1511, 1128)
  if x > -1 then
    tap(1547, 1157)
  end
end

-------------------------------------------准备--------------------------------------
--[[
function ready()
  x, y = findColorInRegionFuzzy(0xcba87f, 95, 1793, 1219, 1945, 1296)
  if x > -1 then
    my_toast(id,"找到准备")
    tap(1879, 1285)
  else
    my_toast(id,"未找到准备")
    sleepRandomLag(1000)
    ready()
  end
end
--]]
function if_start_combat()
	--sysLog('if_start_combat')
	x, y = findMultiColorInRegionFuzzy(0x3b3233,"18|-4|0xdec198,26|15|0x3b3233,29|-36|0x3b3233", 95, 1770-2, 1278-2, 1770+2, 1278+2)  --已经准备
	if x > -1 then
		sleepRandomLag(500)
		my_toast(id, '等待队友准备中')
		if_start_combat()
	end
end


function ready()
	--sysLog('ready')
  --x, y = findImageInRegionFuzzy("准备.png", 40, 1722,1415,2025,1525, 0);
	accept_quest()
  local ready_x, ready_y = findMultiColorInRegionFuzzy(0xfffffa,"5|-39|0xfffff9,27|-34|0xfff3d1,27|-1|0xfffaeb,51|-17|0xfff2d0", 90, 1789, 1274, 1798, 1283)
	if ready_x > -1 then
    my_toast(id,"您已经准备好了")
    tap(1879, 1285)
		mSleep(1000)
		if_start_combat()
		sleepRandomLag(200)
  else
    my_toast(id,"准备开始战斗")
    sleepRandomLag(500)
    ready()
  end
end



-------------------------------------------战斗过程及标记--------------------------------------
function end_combat(tap_situation)
	--sysLog('combat result')
	combat_result = '未知'
	accept_quest()
	local x_defeat, y_defeat = findMultiColorInRegionFuzzy(0x5c5266,"21|-70|0x50495a,82|0|0x595063,37|-11|0xb7a58f,42|31|0xc1ae94,62|77|0xbba689,28|109|0x6c5638,27|146|0x201d25,-54|32|0xbca78a,-5|28|0x230a07", 90, 583, 159, 980, 508)  -- 鼓上的裂纹
	local x_win, y_win = findMultiColorInRegionFuzzy(0x79180f,"49|74|0x951b11,6|52|0xcebfab,-67|124|0xdaceb6,15|112|0xd3c5af,103|115|0xcfbfa9,26|149|0xd8c9b0,20|206|0x580f01,14|238|0x902117,-24|73|0x971b11", 90, 583, 159, 980, 508)  --鼓的红色
	if x_defeat > -1 then
		--combat_win = false
		combat_result = 'defeat'
		sysLog("战斗失败")
		tap(x_defeat, y_defeat)
	elseif x_win > 1 then
		combat_result = 'win'
		--combat_win = true
		sysLog("战斗胜利")
		tap(x_win, y_win) 
		local bool_val = true
		while bool_val do
			accept_quest()
			local x, y = findColorInRegionFuzzy(0x85100f, 85, 1015, 627, 1020, 632)
			if x > -1 then
				my_toast(id,"找到达摩1")
				tap(1020, 850)
				mSleep(200)
				tap(1020, 850)
				mSleep(1000)
				x, y = findColorInRegionFuzzy(0x85100f, 85, 1015, 627, 1020, 632)
				while x > -1 do
				sysLog('还能找到达摩1')
				tap(1020, 850)
				mSleep(200)
				x, y = findColorInRegionFuzzy(0x85100f, 85, 1015, 627, 1020, 632)
				end
				bool_val = false
			else
				sleepRandomLag(100)
			end
		
		end
		bool_val = true
		while bool_val do
			accept_quest()
			local x, y = myFindColor(达摩2)
			if x > -1 then
				my_toast(id,"找到达摩2")
				tap(x, y)
				sleepRandomLag(1000) 
				x, y = myFindColor(达摩2)
			else
				sleepRandomLag(100)
			end
			while x > -1 do
			sysLog('还能找到达摩2')
			tap(x, y)
			sleepRandomLag(1000) 
			x, y = myFindColor(达摩2)
			end
			bool_val = false
		end
		my_toast(id,"结束战斗")
  else
    my_toast(id,"战斗中")
    if_mark(tap_situation)
    sleepRandomLag(200)
		return end_combat(tap_situation)
	end
	return combat_result
end
			
			


-------------------------------------------战斗结果--------------------------------------
--[[
function pla()
  x_defeat, y_defeat = findColorInRegionFuzzy(0x240b08, 95, 705, 323, 714, 333)  -- 鼓上的裂纹
  x_win, y_win = findColorInRegionFuzzy(0x9a1c12, 95, 707, 334, 714, 339)
  if x_defeat > -1 then
    combat_win = true
    sysLog("战斗失败")
    tap(x_defeat, y_defeat)
  else if x_win > 1 then
    combat_win = false
    sysLog("战斗胜利")
  end
end

--]]

-------------------------------------------汇总--------------------------------------
function start_combat(tap_situation)
	accept_quest()
  ready()
  combat_result = end_combat(tap_situation)
	return combat_result
end