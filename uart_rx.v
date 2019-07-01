module uart_rx(clk,rst,h2l,rx_in,bpsclk,rx_en,bpssrt,rx_data,rx_stop);
	input clk,rst,h2l,rx_in,bpsclk;	//前两个程序已经解释了，不再赘述
	input rx_en;	//当其为高电平时，模块运行
	output bpssrt;	//控制波特率设置函数的运行，高电平有效
	output[7:0] rx_data;	//输出接受到的数据
	output rx_stop;
	
	reg[3:0] i;
	//数据位，第0位是起始位，第1到8位是数据位
	//第9位是校验位，第10位是停止位
	//第11到第13位用于产生输入数据结束脉冲isDone
	reg[7:0] rData;//存储接收到的数据
	reg isCount;//生成开始接收数据标志脉冲，输出给波特率定时模块
	reg isDone;//数据输入结束脉冲，用于输出给rx_stop
	always@(posedge clk or negedge rst)
		begin
			if(!rst)
				begin
					i<=4'd0;
					rData<=8'd0;
					isCount<=1'b0;
					isDone<=1'b0;
				end
			else if(rx_en)
				begin
					case(i)
						4'd0: if(h2l) begin i<=i+1'b1; isCount<=1'b1; end	//接收到起始位
						4'd1: if(bpsclk) begin i<=i+1'b1; end	//起始位的采集位
						4'd2,4'd3,4'd4,4'd5,4'd6,4'd7,4'd8,4'd9: 	//第1到第8位
						if(bpsclk) begin i<=i+1'b1; rData[i-2]<=rx_in;	end
						4'd10:
						if(bpsclk)	begin i<=i+1'b1; end
						4'd11:
						if(bpsclk)	begin i<=i+1'b1; end
						4'd12:
						begin i<=i+1'b1; isDone<=1'b1; isCount<=1'b0; end
						4'd13:
						begin i<=4'd0; isDone<=1'b0; end
						default:;
					endcase
				end
		end
	assign bpssrt=isCount;
	assign rx_data=rData;
	assign rx_stop=isDone;
endmodule