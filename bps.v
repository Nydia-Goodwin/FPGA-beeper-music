//串口通信波特率调节模块（波特率可调）
module bps(clk,rst,bpssrt,bpsclk,choose);
//波特率设置函数
	input clk,rst;	
	input bpssrt;	//波特率时钟启动信号置位
	input[1:0] choose;//选择波特率,通过两个拨码开关控制
	output reg bpsclk;	//bpsclk的高电平为接收或者发送数据位的中间采样点
	reg[13:0] bps,smp;	//波特率、采样率
//下面对波特率进行设置
	always//选择波特率
		begin
			case(choose[1:0])
			2'b11:begin bps<=13'd5207; smp<=13'd2603; end //9600波特率
			2'b10:begin bps<=13'd2603; smp<=13'd1301; end //19200波特率
			2'b01:begin bps<=13'd867; smp<=13'd433; end //57600波特率
			2'b00:begin bps<=13'd433; smp<=13'd216; end //115200波特率
			default:begin bps<=bps; smp<=smp; end
			endcase
		end
	
	reg[12:0] cnt;	//分频计数
	always@(posedge clk or negedge rst)
		begin
			if(!rst)
				cnt<=13'd0;
			else if(cnt==bps)
				cnt<=13'd0;
			else if(bpssrt)//如果接受到数据
				cnt<=cnt+1'b1;
			else
				cnt<=13'd0;
		end
//当记到每个计数周期的中位数时产生一个数据采集点		
	always bpsclk = (cnt == smp)? 1'b1: 1'b0;
endmodule