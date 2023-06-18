#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

; Set the new running directory，当前为 weasel-0.15.0 的默认安装目录
NewRunningDir := "C:\Program Files (x86)\Rime\weasel-0.15.0"

; 脚本启动即检测「小狼毫算法服务」是否运行，未运行即手动启动
StartWeaselServer(NewRunningDir)
; 脚本休眠 30 秒
Sleep, 30000
; 休眠过后，第二次检测「小狼毫算法服务」是否运行
StartWeaselServer(NewRunningDir)
return

StartWeaselServer(RunningDir) {
    Process, Exist, WeaselServer.exe
    NewPID := ErrorLevel ; 由于 ErrorLevel 会经常发生改变, 所以要立即保存这个值.
    if not NewPID
    {
        Run, %RunningDir%\WeaselServer.exe
    }
}
