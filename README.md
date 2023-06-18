# WeaselServerAutostart

在开机后，如果发现小狼毫无法输出中文，很可能是算法服务没有正常启动。

解决方法是手动打开小狼毫程序文件夹中的 `WeaselServer.exe`，默认位置为 `C:\Program Files (x86)\Rime\weasel-0.15.0\WeaselServer.exe`。请注意，不要将 `WeaselServer.exe` 设为开机启动，否则可能会导致程序报错。

随着小狼毫成为主力输入法，这个问题变得更加频繁。为了解决这个问题，我使用 AutoHotkey 编写了此脚本，暂时解决了这个问题。

你可以在以下链接的 GitHub 页面下载打包好的 exe 程序：https://github.com/rockbenben/rime-WeaselServer/releases/

## 使用方法

1. 为脚本或程序 `WeaselServerAutostart.exe` 创建一个桌面快捷方式。
2. 将快捷方式移动到开机启动目录。在 Windows 10/11 中，开机启动目录的默认位置是 `%AppData%\Microsoft\Windows\Start Menu\Programs\Startup`。

## 脚本逻辑

1. 检测小狼毫算法服务 `WeaselServer.exe` 是否已经启动。如果没有运行，则脚本会启动与脚本同目录下的 `WeaselServer.exe` 程序。
2. 接着，脚本会休眠 30 秒，然后再次检测算法服务是否已经启动。
