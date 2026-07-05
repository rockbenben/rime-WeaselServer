# WeaselServerAutostart

在开机后，如果发现小狼毫无法输出中文，很可能是算法服务没有正常启动。

解决方法是手动打开小狼毫程序文件夹中的 `WeaselServer.exe`，默认位置为 `C:\Program Files (x86)\Rime\weasel-0.*\WeaselServer.exe`。请注意，不要将 `WeaselServer.exe` 设为开机启动，否则可能会导致程序报错。

随着小狼毫成为主力输入法，这个问题变得更加频繁。为了解决这个问题，我使用 AutoHotkey 编写了此脚本，暂时解决了这个问题。

下载打包好的 exe 程序：<https://github.com/rockbenben/rime-WeaselServer/releases/>

本仓库提供两个功能等价的脚本，任选其一即可：

- `WeaselServerAutostart.ahk`：**AutoHotkey v2** 脚本（需安装 [AutoHotkey v2](https://www.autohotkey.com/)，或使用打包好的 exe）。
- `WeaselServerAutostart.ps1`：**PowerShell** 脚本，逻辑与 ahk 版本一致。适合不想安装 AutoHotkey、或打包 exe 被杀毒软件误报的用户，无需额外依赖。

## 使用方法

### 方式一：AutoHotkey / exe

1. 为脚本 `WeaselServerAutostart.ahk`（需已安装 AutoHotkey v2）或打包程序 `WeaselServerAutostart.exe` 创建一个桌面快捷方式。如果你的输入法是绿色版或非默认路径安装，则将脚本/程序放入小狼毫的「程序文件夹」内，然后生成快捷方式。
2. 将快捷方式移动到开机启动目录。在 Windows 10/11 中，开机启动目录的默认位置是 `%AppData%\Microsoft\Windows\Start Menu\Programs\Startup`。

### 方式二：PowerShell（避免杀毒误报）

PowerShell 默认禁止直接双击运行 `.ps1`，需通过快捷方式绕过执行策略：

1. 在开机启动目录 `%AppData%\Microsoft\Windows\Start Menu\Programs\Startup` 中，新建一个快捷方式，目标填写：

   ```
   powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "C:\Program Files (x86)\Rime\WeaselServerAutostart.ps1"
   ```

   请将 `-File` 后的路径改为你实际存放 `WeaselServerAutostart.ps1` 的位置。若脚本与 `WeaselServer.exe` 同目录（放入小狼毫「程序文件夹」内），可自动识别路径。
2. `-WindowStyle Hidden` 用于隐藏运行时的窗口。

## 脚本逻辑

脚本在三个检查点（立刻 / +30 秒 / +180 秒）复查算法服务状态：

1. 检测小狼毫算法服务 `WeaselServer.exe` 是否已经启动。如果没有运行，则脚本会启动与脚本同目录下的 `WeaselServer.exe` 程序。如果目录中没有该程序，脚本会动态查找 weasel 的默认安装路径（先 `C:\Program Files (x86)\Rime`，再 `C:\Program Files\Rime`，支持多版本）。
2. 然后，脚本会休眠 30 秒，并再次检测算法服务是否已经启动。
3. 接着，脚本休眠 180 秒，最后检测一次算法服务是否已经启动。

任意一个检查点发现服务已在运行，脚本便立即退出、不再空等；三次检查后无论结果如何，程序都将自动退出。
