# WeaselServerAutostart
开机后，小狼毫不能输出中文，大都是因为算法服务没有正常启动。

手动打开小狼毫「程序文件夹」中的`WeaselServer.exe`即可恢复，默认位置为`C:\Program Files (x86)\Rime\weasel-0.14.3\WeaselServer.exe`。注意：不要手动将`WeaselServer.exe`设为开机启动，否则程序容易报错。

随着小狼毫升级为主力输入法，这问题愈加频繁，就用 autohotkey 写了脚本，暂时解决。

github 下载：https://github.com/rockbenben/rime-WeaselServer/releases/

国内蓝奏云：https://wwx.lanzoux.com/if3znkka01g

## 使用方法
1. 将生成的程序`WeaselServerAutostart.exe`，放入小狼毫「程序文件夹」内，并生成桌面快捷方式。
2. 将快捷方式移动至开机启动目录，Win10 默认位置为`%AppData%\Microsoft\Windows\Start Menu\Programs\Startup`。

## 脚本逻辑
1. 检测小狼毫算法服务`WeaselServer.exe`是否启动。如果未运行，则启动脚本同目录下的`WeaselServer.exe`程序。
2. 接着，脚本休眠 30 秒，再次检测算法服务是否启动。
