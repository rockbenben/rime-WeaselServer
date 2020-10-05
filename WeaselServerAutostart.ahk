#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; 脚本启动即检测「小狼毫算法服务」是否运行，未运行即手动启动
Process, Exist, WeaselServer.exe
NewPID := ErrorLevel  ; 由于 ErrorLevel 会经常发生改变, 所以要立即保存这个值.
if not NewPID
{
 Run %A_WorkingDir%\WeaselServer.exe
}
; 脚本休眠 30 秒
Sleep, 30000
; 休眠过后，第二次检测「小狼毫算法服务」是否运行
Process, Exist, WeaselServer.exe
NewPID := ErrorLevel  ; 由于 ErrorLevel 会经常发生改变, 所以要立即保存这个值.
if not NewPID
{
 Run %A_WorkingDir%\WeaselServer.exe
}
return
