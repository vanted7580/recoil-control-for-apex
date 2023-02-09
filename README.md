# VANTED.CC | RECOIL CONTROL for APEX

Lua for Logitech G HUB.

## 调整参数
### 参数设置
    local recoilConfig =
    {
      {
        name            = "Default", --配置文件名称
        recoilMoveY     = 1, --Y移动
        recoilMoveX     = 5, --X基础移动
        randomMoveX     = 8, --X随机移动
        interval        = 4, --动作间隔
        timeout         = 2500, --最大启用时间
        delay           = 0, --启用延迟
      }
    }
    
### 程序设置
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
