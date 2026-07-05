#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode("Input")
SetWorkingDir(A_ScriptDir)

; 检测脚本目录是否有 WeaselServer.exe
if FileExist(A_ScriptDir "\WeaselServer.exe")
    NewRunningDir := A_ScriptDir                       ; 有就用脚本目录
else {
    ; 动态查找最新版本的 weasel 目录
    NewRunningDir := FindLatestWeaselDir("C:\Program Files (x86)\Rime")
    if (NewRunningDir = "")
        NewRunningDir := FindLatestWeaselDir("C:\Program Files\Rime")
}

; 三个检查点（立刻 / +30s / +180s）：一旦发现服务在跑就立刻收工、不再空等；
; 没起就拉起，等下一轮复查确认。（原脚本会把 3.5 分钟睡满才退出，这里改成起来即退出）
for delay in [0, 30000, 180000] {
    if (delay > 0)
        Sleep(delay)
    if ProcessExist("WeaselServer.exe")
        ExitApp()                                   ; 已经在跑 → 无需再等，直接退出
    try Run(NewRunningDir "\WeaselServer.exe")      ; 没起 → 拉起；路径无效时 try 吞掉错误（静默失败）
}
ExitApp()

; 查找最新版本的 weasel-* 目录（按名称排序取最后一个）
FindLatestWeaselDir(baseDir) {
    latestDir := ""
    Loop Files, baseDir "\weasel-*", "D"
        latestDir := A_LoopFileFullPath
    return latestDir
}
