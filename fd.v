//按键防抖程序
module fd(cp,rst,key,key_pulse);
	parameter N=7;//要消除抖动的按键数量
	input cp;
	input rst;
	input[N-1:0] key;//输入的按键
	output[N-1:0] key_pulse;//按键动作产生的脉冲
	reg[N-1:0] key_pre;//上一时刻触发的按键值
	reg[N-1:0] key_rst;//当前时刻触发的按键值
	reg[17:0] cnt=0;
	wire[N-1:0] key_edge;
	//将两个时钟触发时的按键状态存储在两个寄存器变量中
	always@(posedge cp or negedge rst)
		begin
			if(!rst)
				begin
				key_rst<={N{1'b1}};
				key_pre<={N{1'b1}};
				end
			else begin
				key_rst<=key;
				key_pre<=key_rst;
				end
			end
	assign key_edge=(key_pre&(~key_rst));//检测按键按下，即按键输入下降沿，当出现下降沿时key_edge为1，下降沿过去后恢复为0
	//下面这部分产生延迟，当检测到key_edge时开始计数
	//	延时后检测key，如果key_edge变为1后在越10ms内再次出现1，说明为抖动，计数清零，直到检测到稳定的key=0	
	always@(posedge cp or negedge rst)			
		begin
			if(!rst)
				cnt<=18'h0;
			else if(key_edge)
				cnt<=18'h0;
			else
				cnt<=cnt+1'h1;
		end
	
	reg[N-1:0] key_sec_pre;//延时检测后寄存按键状态
	reg[N-1:0] key_sec;//key_sec_pre的下一个状态

	always@(posedge cp or negedge rst)
		begin
			if(!rst)
				key_sec<={N{1'b1}};
			else if(cnt==18'h3ffff)
				key_sec<=key;
		end
	//当检测到稳定的key（约10ms不变），将key的值送给key_sec
	//下面是检测经过消抖后的key的下降沿（key按下）
	always@(posedge cp or negedge rst)
		begin
			if(!rst)
				key_sec_pre<={N{1'b1}};
			else
				key_sec_pre<=key_sec;
			end
				
	assign key_pulse=key_sec_pre&(~key_sec);//消抖后的key为下降沿则输出一个1，下降沿过后输出0
endmodule