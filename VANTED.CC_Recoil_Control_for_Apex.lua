--[[
  
  Created by VANTED
  
  Repository: https://github.com/wqy224491/recoil-control-for-apex
  
  This product is available for GPL-3.0 License in repository.
  
  Current version: 1.5
  
]]

--Define
local PROFILE_ACTIVATED      = "PROFILE_ACTIVATED"
local PROFILE_DEACTIVATED    = "PROFILE_DEACTIVATED"
local MOUSE_BUTTON_PRESSED   = "MOUSE_BUTTON_PRESSED"
local MOUSE_BUTTON_RELEASED  = "MOUSE_BUTTON_RELEASED"
local MSG_LEVEL_NORMAL       = "INFO"
local MSG_LEVEL_WARN         = "WARN"
local MSG_LEVEL_ERROR        = "ERROR"

--参数设置
local recoilConfig =
{
  {
    name            = "Default", --配置文件名称
    recoilMoveY     = 2, --Y移动
    recoilMoveX     = 7, --X基础移动
    randomMoveX     = 0, --X随机移动
    interval        = 1, --动作间隔
    timeout         = 3000, --最大启用时间
    boostTime       = 1000,  --灵敏度增强时间
    boostRate       = 1.5,  --灵敏度增强倍率
    delay           = 0, --启用延迟
  },
  {
    name            = "Off",
    recoilMoveY     = 0,
    recoilMoveX     = 0,
    randomMoveX     = 0,
    interval        = 0,
    timeout         = 0,
    boostTime       = 0,
    boostRate       = 0,
    delay           = 0,
  }
}


--程序设置
local scriptConfig = 
{
  buttons = 
  {
    --开火和瞄准按键
    fire   = 1,
    scope  = 3,
    --配置循环按键
    loop   = 8
  },
  --输出控制台信息
  debugMSG = true
}


--程序主体
local function printMSG(msg, level, force)
  if level == none then
    msg = "["..MSG_LEVEL_NORMAL.."] "..msg
  else
    msg = "["..level.."] "..msg
  end
  
  msg = "["..tostring(GetRunningTime()/1000).."]"..msg
  
  if scriptConfig.debugMSG == true or force == true then
    return OutputLogMessage(msg .. "\n")
  end
end
local tempVar = 
{
  curProfile     = 1,
  minProfile     = 1,
  maxProfile     = #recoilConfig,
}

local function init()
  EnablePrimaryMouseButtonEvents(true) 
  ClearLog()
  printMSG("Welcome! Created by VANTED.", none, true)
  printMSG("This script shared in GPL-3.0 license.", none, true)
  printMSG("Profile activated: "..recoilConfig[tempVar.curProfile].name.."\n")
end

local function unload()
  ClearLog()
  printMSG("Goodbye!", none, true)
end

local function loopProfile(event, arg, ...)
  
  
  if event == MOUSE_BUTTON_RELEASED
    and arg == scriptConfig.buttons.loop then
    
    if tempVar.curProfile >= tempVar .maxProfile then
      tempVar.curProfile = tempVar .minProfile
    else
      tempVar.curProfile = tempVar .curProfile + 1
    end
        
    printMSG("Profile activated: "..recoilConfig[tempVar.curProfile].name)
    
  end
  
end

local function reduceRecoil(event, arg, ...)

  local startTime = GetRunningTime()

  local moveY   = recoilConfig[tempVar.curProfile].recoilMoveY
  local moveX   = recoilConfig[tempVar.curProfile].recoilMoveX
  local randomX = recoilConfig[tempVar.curProfile].randomMoveX     
  local interval= recoilConfig[tempVar.curProfile].interval
  local timeout = recoilConfig[tempVar.curProfile].timeout
  local delay   = recoilConfig[tempVar.curProfile].delay
  local boostTime = recoilConfig[tempVar.curProfile].boostTime
  local boostRate = recoilConfig[tempVar.curProfile].boostRate

  local firePressed = false
  local scopePressed = false

  local msgSent = false
  local reachLimit = false
  repeat

    firePressed = IsMouseButtonPressed(scriptConfig.buttons.fire)
    scopePressed = IsMouseButtonPressed(scriptConfig.buttons.scope)
  
    if firePressed and scopePressed then
  
      if msgSent == false then
        msgSent = true
        printMSG("Recoil conrol started with profile '" .. recoilConfig[tempVar.curProfile].name .."'.")
      end
  
      if GetRunningTime() - startTime >= delay and reachLimit == false then
  
        local rdX = math.random(0, randomX)
        local rdY = 0 --math.random(-1, 2)
    
        local dif = GetRunningTime() - startTime
    
        if dif > timeout then
          break
        end
    
        local rate = 1
        
        if dif < boostTime then
          rate = ((1 - (dif / boostTime))*boostRate ) + 1
        else
          rate = 1
        end
        
        intervalTmp = interval
        moveXtmp  = moveX + rdX 
        moveYtmp = math.floor(rate * moveY) + rdY 
 
        MoveMouseRelative(-moveXtmp, 6)
        Sleep(intervalTmp)
        MoveMouseRelative(moveXtmp, -(6-moveYtmp))
        Sleep(intervalTmp)
        MoveMouseRelative(-moveXtmp, 6)
        Sleep(intervalTmp)
        MoveMouseRelative(moveXtmp, -(6-moveYtmp))
        Sleep(intervalTmp)
        
      end
      
    else
      reachLimit = false
      startTime = GetRunningTime()
    end
    
    if GetRunningTime() - startTime >= timeout and msgSent==true then
      reachLimit = true
    elseif msgSent == false then
      startTime = GetRunningTime()
    end
    
  until((firePressed == false and scopePressed == false))
  
  if msgSent == true then
      printMSG("Recoil conrol stoped.")
  end
  
end

function OnEvent(event, arg, ...)

  if event == PROFILE_ACTIVATED  then
    init()
    return
  end
  
  if event == PROFILE_DEACTIVATED then
    unload()
    return
  end
  
  loopProfile(event, arg, ...)
  reduceRecoil(event, arg, ...)
  
end
