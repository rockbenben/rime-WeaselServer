# WeaselServerAutostart
开机后，小狼毫不能输出中文，大都是因为算法服务没有正常启动。手动打开小狼毫「程序文件夹」中的`WeaselServer.exe`即可恢复，默认位置为`C:\Program Files (x86)\Rime\weasel-0.14.3\WeaselServer.exe`。
注意：不要手动将`WeaselServer.exe`设为开机启动，否则程序容易报错。

随着小狼毫升级为主力输入法，这问题愈加频繁，就用 autohotkey 写了脚本，暂时解决。

## 使用方法
1. 将生成的程序`WeaselServerAutostart.exe`，放入小狼毫「程序文件夹」内，并生成桌面快捷方式。
2. 将快捷方式移动至系统启动目录，Win10 默认位置为`C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp`。

## 脚本逻辑
开机 5 秒启动检测程序，查看算法服务是否启动。未启动的话，启动脚本同目录下的`WeaselServer.exe`程序。
