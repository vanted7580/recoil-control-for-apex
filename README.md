# VANTED.CC | RECOIL CONTROL for APEX

Lua for Logitech G HUB.

## 调整参数
### 参数设置
    local recoilConfig =
    {
      {
        name            = "Default", --配置文件名称
        recoilMoveY     = 2, --Y移动
        recoilMoveX     = 10, --X基础移动
        randomMoveX     = 0, --X随机移动
        interval        = 1, --动作间隔
        timeout         = 2500, --最大启用时间
        boostTime       = 700,  --灵敏度增强时间
        boostRate       = 2,  --灵敏度增强倍率
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

## License

[VANTED.CC_Recoil_Control_for_Apex.lua](https://github.com/wqy224491/recoil-control-for-apex/blob/main/VANTED.CC_Recoil_Control_for_Apex.lua) is available for [GPL-3.0 License](https://github.com/wqy224491/MSR-GAMING-ASSISTANT/blob/main/LICENSE) in files.

此脚本适用于[GPL-3.0 协议](https://github.com/wqy224491/MSR-GAMING-ASSISTANT/blob/main/LICENSE)。

<img src="https://upload.cc/i1/2023/01/01/0nyLFI.png" width="280">
