-- 作者yluo37
-- 时间: 2016-12-28
function myFindColor(input_table)
	accept_quest()
	local x, y = findMultiColorInRegionFuzzy(input_table[1], input_table[2], input_table[3], input_table[4], input_table[5], input_table[6], input_table[7])
	return x, y
	end

function toast_screensize()
  width,height = getScreenSize()
  if (width == 960 and height== 640 )or (width==640 and height==960 ) 		then--4
    device_type="4"
  elseif (width == 640 and height== 1136 )or (width==1136 and height==640 ) 		then--5
    device_type="5"
  elseif(width==750 and height==1334 )or (width==1334 and height==750 ) 		then--6
    device_type="6"
  elseif(width==1242 and height==2208 )or (width==2208 and height==1242) 	then--6p
    device_type="6p"
  elseif(width==1024 and height==768 )or (width==768 and height==1024 ) 		then--2
    device_type="ipad2"
  elseif(width==2048 and height==1536 )or (width==1536 and height==2048 ) 	then--4
    device_type="ipad4"
  else
    toast("暂不支持此设备,sorry~") --暂不支持此设备
    lua_exit()
  end
  toast(device_type)
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

function printTable(t)
for key,value in pairs(t) do sysLog(key..': '..value) end
end


function my_toast(id, my_string)
  showHUD(id, my_string ,50,"0xffffffff",'hud2.png',0,100,95,600,78)    
end


function if_outof_sushi()
	mSleep(500)
  x, y = findMultiColorInRegionFuzzy(0xe32e16,"-24|-124|0x60466e,-16|14|0xc6a98a,91|4|0xf3b25e", 93, 976, 931, 1023, 974)
  if x > -1 then
    my_toast(id, '已经没有体力啦！')
    lockDevice()
		lua_exit()
  end
end




function my_exist(lock)
  if lock == true then
    lockDevice()
    lua_exit()
  else
    lua_exit();
  end
end




function sleepRandomLag(default)
  lag = math.random(default-100,default+100)
  mSleep(lag)
end

-- 格式化输出
function sysLogFmt(fmt, ...)
  sysLog(string.format(fmt, ...))
end

-- 任意输出
function sysLogLst(...)
  local msg = ''
  for k,v in pairs({...}) do
    msg = string.format('%s %s ', msg, tostring(v))
  end
  sysLog(msg)
end

function tap(x, y)
  accept_quest()
  math.randomseed(tostring(os.time()):reverse():sub(1, 6))  --设置随机数种子
  local index = math.random(1,5)
  local rand_x = x + math.random(-2,2)
  local rand_y = y + math.random(-2,2)
  touchDown(index,rand_x, rand_y)
  mSleep(math.random(60,80))                --某些特殊情况需要增大延迟才能模拟点击效果
  touchUp(index, rand_x, rand_y)
  mSleep(20)
end

-- 模拟滑动操作，从点(x1, y1)划到到(x2, y2)
function swip(x1,y1,x2,y2)
  local step, x, y, index = 20, x1 , y1, 0
  touchDown(index, x, y)
  
  local function move(from, to) 
    if from > to then
      do 
        return -1 * step 
      end
    else 
      return step 
    end 
  end
  
  while (math.abs(x-x2) >= step) or (math.abs(y-y2) >= step) do
    if math.abs(x-x2) >= step then x = x + move(x1,x2) end
    if math.abs(y-y2) >= step then y = y + move(y1,y2) end
    touchMove(index, x, y)
    mSleep(20)
  end
  
  touchMove(index, x2, y2)
  mSleep(30)
  touchUp(index, x2, y2)
end

function my_swip(x1, y1, x2, y2, speed)
	local new = pos:new(x1, y1)
	local move = {x=x2, y=y2}
	local step = 28
	local sleep1,sleep2 = 500,20
	new:touchMoveTo(move,step,sleep1,sleep2)
end

--分割@字符串函数
function str_split(input_str)
  output_table = {}
  for word in string.gmatch(input_str, '([^@]+)') do
    table.insert(output_table,tonumber(word))
  end
  return output_table
end

-- 多点颜色对比，格式为{{x,y,color},{x,y,color}...} 
function cmpColor(array, s, isKeepScreen)
  s = s or 90
  s = math.floor(0xff * (100 - s) * 0.01)
  isKeepScreen = isKeepScreen or false
  
  local lockscreen = function(flag)
    if isKeepScreen == true then
      keepScreen(flag)
    end
  end
  
  lockscreen(true)
  for i = 1, #array do
    local lr,lg,lb = getColorRGB(array[i][1], array[i][2])
    local rgb = array[i][3]
    
    local r = math.floor(rgb/0x10000)
    local g = math.floor(rgb%0x10000/0x100)
    local b = math.floor(rgb%0x100)
    
    if math.abs(lr-r) > s or math.abs(lg-g) > s or math.abs(lb-b) > s then
      lockscreen(false)
      return false
    end
  end
  
  lockscreen(false)
  return true
end


--switch function, used for switch cases
function switch(t)
  t.case = function (self,x)
    local f=self[x] or self.default
    if f then
      if type(f)=="function" then
        f(x,self)
      else
        error("case "..tostring(x).." not a function")
      end
    end
  end
  return t
end




--[[
a = switch {
  [1] = function (x) print(x,10) end,
  [2] = function (x) print(x,20) end,
  default = function (x) print(x,0) end,
}

input:
a:case(2)  -- ie. call case 2 
a:case(9)

output:
2	20
9	0
--]]


function getKeysSortedByValue(tbl, sortFunction)
  local keys = {}
  for key in pairs(tbl) do
    table.insert(keys, key)
  end
  table.sort(keys, function(a, b)
  return sortFunction(tbl[a], tbl[b])
end)

return keys
end


function check_current_state()
	keepScreen(true)
	local scroll_x, scroll_y = findMultiColorInRegionFuzzy(0xda5b39,"-10|10|0x521611,-19|26|0x361b0c,23|-48|0xd9cbc4,38|-86|0x86221f,64|-114|0xd9cbc4,85|-143|0xc8a172,92|-162|0x9d6847,1|-15|0xa5704c", 90, 1739, 1259, 2045, 1538)
  local main_x, main_y = findMultiColorInRegionFuzzy(0x8f5ea0,"-45|-4|0xbdb5a4,-38|45|0xf8f3e0,59|17|0x603d3a", 90, 434,1413, 438, 1417)
  local intansuo_x, intansuo_y = findColorInRegionFuzzy(0x2e4432, 95, 3, 1525, 9, 1531); --战斗界面左下角绿色
  local tansuo_x, tansuo_y = findColorInRegionFuzzy(0x1e1ea6, 95, 314, 1493, 340, 1509) -- 探索yuhun下方蓝色
  local incombat_x, incombat_y = findColorInRegionFuzzy(0x856e56, 95, 86, 1485, 110, 1494) --战斗左下角小齿轮颜色
  local tupo_x, tupo_y = findMultiColorInRegionFuzzy(0xc7241c,"-13|8|0xf7f2df,-14|-35|0xf4efe1", 95, 888, 1078, 888, 1078)  --3次达摩周边色
  local yuhun_x, yuhun_y = findMultiColorInRegionFuzzy(0xf3b25e,"-82|54|0x423a33,-87|-34|0x342f27,-62|9|0x302a23", 95, 1450,980,1460, 990)
	local yeyuanhuo_x, yeyuanhuo_y = myFindColor(业原火)
	local yeyuanhuo_challenge_x, yeyuanhuo_challenge_y = myFindColor(业原火挑战)
	local party_x, party_y = myFindColor(组队界面)
	local tap_exit_x, tap_exit_y = myFindColor(顶点退出)
	local redcross_x, redcross_y = myFindColor(右上红叉)
	local defeat_x, defeat_y = findMultiColorInRegionFuzzy(0x5c5266,"21|-70|0x50495a,82|0|0x595063,37|-11|0xb7a58f,42|31|0xc1ae94,62|77|0xbba689,28|109|0x6c5638,27|146|0x201d25,-54|32|0xbca78a,-5|28|0x230a07", 90, 583, 159, 980, 508)  -- 鼓上的裂纹
	local win_x, win_y = findMultiColorInRegionFuzzy(0x79180f,"49|74|0x951b11,6|52|0xcebfab,-67|124|0xdaceb6,15|112|0xd3c5af,103|115|0xcfbfa9,26|149|0xd8c9b0,20|206|0x580f01,14|238|0x902117,-24|73|0x971b11", 90, 583, 159, 980, 508)  --鼓的红色
	local chat_cross_x, chat_cross_y = myFindColor(聊天红叉)
	local creat_x = myFindColor(创建队伍)
	
	
	keepScreen(false)
	
	if scroll_x > -1 then
		tap(scroll_x, scroll_y)
		mSleep(1000)
		return check_current_state()
	end

  if main_x > -1 then        
    sysLog('当前处于庭院或者町中。。。')
    my_toast(id, '当前处于庭院或者町中。。。')
		my_swip(1800, 1250, 200, 1250, 50)
		local machi_x, machi_y = findMultiColorInRegionFuzzy(0xbeb6b3,"3|25|0xb9b5c3,1|40|0x141412,-1|228|0x979793", 95, 1540,460,1550,480)
    if machi_x > -1 then
			sysLog('当前处于町中。。。')
      return 'machi'
		else
			sysLog('当前处于庭院')
			return 1
    end
  elseif intansuo_x > -1 then
    if incombat_x > -1 then
      sysLog("当前处于战斗中。。。")
			end_combat(0)
			mSleep(2000)
			return check_current_state()
    else 
      sysLog('当前处于探索副本里。。。')
      return 22
    end
  elseif tansuo_x > -1 then      --如果没找到符合条件的
    sysLog("当前处于探索界面。。。");
    return 3
  elseif tupo_x > -1 then
    sysLog("当前处于突破界面")
    return 'tupo'
  elseif intansuo_x > -1 then
    if incombat_x > -1 then
      sysLog("当前处于御魂中。。。")
    end
    return 5
	elseif yeyuanhuo_x > -1 then
		sysLog('yeyuanhuo')
    return 'yeyuanhuo'
	elseif yeyuanhuo_challenge_x > -1 then
		sysLog('yeyuanhuo_challenge')
		return 'yeyuanhuo_challenge'
	elseif party_x > -1 then
		sysLog('party')
		return 'party'
	elseif tap_exit_x > -1 then
		my_toast(id, '稍等')
		tap(tap_exit_x, tap_exit_y)
		mSleep(500)
		return check_current_state()
	elseif redcross_x > -1 then
		my_toast(id, '稍等')
		tap(redcross_x, redcross_y)
		mSleep(500)
		return check_current_state()
	elseif chat_cross_x > -1 then
		my_toast(id, '聊天界面')
		tap(chat_cross_x, chat_cross_y)
		mSleep(500)
		return check_current_state()
	elseif defeat_x > -1 or win_x > -1 then
		end_combat()
		mSleep(1000)
		return check_current_state()
  elseif  creat_x > -1 then
		my_toast(id, '创建队伍界面')
		return 'create_party'
	else
    my_toast(id, "当前界面未知");
		mSleep(1000)
		return check_current_state()
  end
end	



function accept_quest()
  --x, y = findImageInRegionFuzzy("悬赏.png", 70, 1323,822,1407,877, 0);
  local accept_x, accept_y = findMultiColorInRegionFuzzy(0x60ba6b,"1|-16|0x342325,-12|-1|0x58b563,22|-4|0x60ba6b,2|41|0x322124", 95, 1357, 847, 1361, 851)
  if accept_x > -1 then
    sysLog("找到悬赏")
    touchDown(1, accept_x, accept_y)
    mSleep(30)
    touchUp(1, accept_x,accept_y)
    sleepRandomLag(300)
  end
end
