# WeaselServerAutostart.ps1
# 与 WeaselServerAutostart.ahk (AutoHotkey v2) 功能一致的 PowerShell 版本。
# 用途：开机后确保小狼毫算法服务 WeaselServer.exe 已启动，避免无法输出中文。
#
# 运行方式（PowerShell 默认禁止直接双击运行 .ps1，需绕过执行策略）：
#   powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "WeaselServerAutostart.ps1"
# 详见 README。

# 脚本所在目录
$ScriptDir = if ($PSScriptRoot) { $PSScriptRoot } else { Split-Path -Parent $MyInvocation.MyCommand.Path }

# 查找最新版本的 weasel-* 目录（按名称排序取最后一个）
function Find-LatestWeaselDir($baseDir) {
    if (-not (Test-Path $baseDir)) { return "" }
    $dir = Get-ChildItem -Path $baseDir -Directory -Filter "weasel-*" -ErrorAction SilentlyContinue |
        Sort-Object Name | Select-Object -Last 1
    if ($dir) { return $dir.FullName } else { return "" }
}

# 检测脚本目录是否有 WeaselServer.exe
if (Test-Path (Join-Path $ScriptDir "WeaselServer.exe")) {
    $NewRunningDir = $ScriptDir                              # 有就用脚本目录
} else {
    # 动态查找最新版本的 weasel 目录
    $NewRunningDir = Find-LatestWeaselDir "C:\Program Files (x86)\Rime"
    if ($NewRunningDir -eq "") {
        $NewRunningDir = Find-LatestWeaselDir "C:\Program Files\Rime"
    }
}

# 三个检查点（立刻 / +30s / +180s）：一旦发现服务在跑就立刻收工、不再空等；
# 没起就拉起，等下一轮复查确认。（起来即退出，不会把 3.5 分钟睡满）
foreach ($delay in 0, 30, 180) {
    if ($delay -gt 0) { Start-Sleep -Seconds $delay }
    if (Get-Process -Name "WeaselServer" -ErrorAction SilentlyContinue) {
        exit                                                # 已经在跑 → 无需再等，直接退出
    }
    # 没起 → 拉起；路径无效时静默失败
    $exe = Join-Path $NewRunningDir "WeaselServer.exe"
    if ($NewRunningDir -and (Test-Path $exe)) {
        Start-Process -FilePath $exe -WorkingDirectory $NewRunningDir -ErrorAction SilentlyContinue
    }
}
exit
