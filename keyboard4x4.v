//键盘输出模块
module keyboard4x4(row,clk,start,column,dout);
	output[3:0] row;//列扫描信号
	output reg[7:0] dout;//第四位为标志位，有效为1，无效为0
	input clk,start;//扫描时钟信号、开始信号，高电平有效
	input[3:0] column;//行扫描信号
	reg[3:0] row;
	reg[1:0] count;//计数器
	reg[1:0] sta;//数据选择器
	reg[7:0] dat;//寄存器
	reg[20:0] div=0;//div用于对时钟分频
	reg fn,cp=0;
	
	initial dout=5'b00000;
	always @(posedge clk)
		begin
			div=div+1;
			if(div==21'd2500000)//将扫描时间间隔降为10us
			begin
				cp=~cp;
				div=0;
			end
		end
		
	//循环扫描计数器
	always @(posedge cp)
		begin
		if(start==0)
			begin dat<='b00000000; end
		else
			begin
				count<=count+1;
				case(count)
				2'b00:begin row<='b1110;sta<='b00;end
				2'b01:begin row<='b1101;sta<='b01;end
				2'b10:begin row<='b1011;sta<='b10;end
				2'b11:begin row<='b0111;sta<='b11;end
				endcase
			//行扫描译码
				case(sta)
				2'b00:begin
					case(column)
					4'b1110:dat<='b00101111;//(4,4)
					4'b1101:dat<='b00101011;//(3,4)
					4'b1011:dat<='b00010111;//(2,4)
					4'b0111:dat<='b00010011;//(1,4)
					default:dat<='b00000000;
					endcase
					end
				2'b01:begin
					case(column)
					4'b1110:dat<='b00101110;//(4,3)
					4'b1101:dat<='b00101010;//(3,3)
					4'b1011:dat<='b00010110;//(2,3)
					4'b0111:dat<='b00010010;//(1,3)
					default:dat<='b00000000;
					endcase
					end
				2'b10:begin
					case(column)
					4'b1110:dat<='b00101101;//(4,2)
					4'b1101:dat<='b00101001;//(3,2)
					4'b1011:dat<='b00010101;//(2,2)
					4'b0111:dat<='b00010001;//(1,2)
					default:dat<='b00000000;
					endcase
					end
				2'b11:begin
					case(column)
					4'b1110:dat<='b00101100;//(4,1)
					4'b1101:dat<='b00101000;//(3,1)
					4'b1011:dat<='b00010100;//(2,1)
					4'b0111:dat<='b00010000;//(1,1)
					default:dat<='b00000000;
					endcase
					end
				default:dat<='b00000000;
				endcase
			end
		end	
		
		//产生按键标志位，用于存储按键信息		
		always
			fn<=(dat[0]||dat[1]||dat[2]||dat[3]||dat[4]||dat[5]||dat[6]||dat[7]); 
			
		always@(posedge fn)
			begin dout[7:0]<=dat[7:0]; end
endmodule
