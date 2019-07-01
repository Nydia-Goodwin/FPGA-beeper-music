# FPGA串口通信电子琴
这个“电子琴”，可以通过按键控制蜂鸣器鸣响不同的音调，实现用FPGA演奏乐器的功能，同时，按键位对应的音符信息可以实时显示在数码管上，并可以发送到PC上在串口调试助手中保存成文件。PC端也可以在演奏同时通过串口调试助手将十六进制数传入FPGA开发板并显示在数码管的前两位（体现“全双工”的特点）。此外，本程序可以通过前两路拨码开关调节UART通信的波特率。至于现实意义，它可以作为广大工科生在钻研工程技术的同时陶冶情操，走近音乐的重要渠道和放松手段（比如我实现了功能后就玩了两个多小时），同时这个程序对板载资源和前几次实验中积累的verilog HDL建模技巧进行了全面的复习，也可以考虑作为以后的教学实验。
实现这一功能包括的板载资源有4x4矩阵键盘、数码管、拨码开关、蜂鸣器、按键、RS232串口等。分别实现了键盘扫描输入，数码管动态显示，蜂鸣器频率控制，按键消抖，RS232串口通信，波特率调节等。下面对之前实验没有使用过的蜂鸣器进行简单叙述，并对引脚分配和按键控制音调进行说明。
