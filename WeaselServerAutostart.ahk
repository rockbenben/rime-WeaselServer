#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

; 检测当前脚本目录是否有 WeaselServer.exe 程序
IfExist, %A_ScriptDir%\WeaselServer.exe
    NewRunningDir := A_ScriptDir ; 如果有，将脚本目录设置为运行目录
Else
{
    ; 动态查找最新版本的 weasel 目录
    NewRunningDir := FindLatestWeaselDir("C:\Program Files (x86)\Rime")
    If (NewRunningDir = "")
        NewRunningDir := FindLatestWeaselDir("C:\Program Files\Rime")
}

; 脚本启动后首先检查「小狼毫算法服务」是否已启动，如未启动，则手动启动
StartWeaselServer(NewRunningDir)

; 脚本休眠 30 秒
Sleep, 30000

; 休眠结束后，再次检查「小狼毫算法服务」是否已启动
StartWeaselServer(NewRunningDir)

; 脚本再次休眠 180 秒
Sleep, 180000

; 休眠结束后，最后检查一次「小狼毫算法服务」是否已启动
StartWeaselServer(NewRunningDir)

; 无论结果如何，结束脚本
ExitApp

; 定义函数：启动 WeaselServer
StartWeaselServer(RunningDir) {
    Process, Exist, WeaselServer.exe
    NewPID := ErrorLevel ; ErrorLevel 的值可能会经常变化，所以需要立即保存这个值
    if not NewPID
    {
        Run, %RunningDir%\WeaselServer.exe
    }
}

; 定义函数：查找最新版本的 weasel 目录
FindLatestWeaselDir(baseDir) {
    latestDir := ""
    Loop, Files, %baseDir%\weasel-*, D
    {
        latestDir := A_LoopFileFullPath
    }
    return latestDir
}
