//串口通信模块
module uart_tx(clk,rst,tx_en,tx_data,bpsclk,tx_stop,tx_out);
	input clk,rst,bpsclk;
	input tx_en;	//当其为高电平时，模块运行
	input[7:0] tx_data;
	output tx_stop,tx_out;
	
	reg[3:0] i;
	//数据位，第0位是起始位，寄存器rTX被赋值为逻辑0
	//第1到8位为数据位，第9位是校验位，第10位是停止位
	//校验位和停止位如果没有特殊需求，可以赋值为1
	//第11到13位用于产生正脉冲tx_stop,标示本数据发送结束
	reg rTX;
	reg isDone;
	always@(posedge clk or negedge rst)
		begin
			if(!rst)
				begin
					i<=4'd0;
					rTX<=1'b1;
					isDone<=1'b0;
				end
			else if(tx_en)
				case(i)
					4'd0:
					if(bpsclk) begin i<=i+1'b1;rTX<=1'b0; end
					4'd1,4'd2,4'd3,4'd4,4'd5,4'd6,4'd7,4'd8:
					if(bpsclk) begin i<=i+1'b1;rTX<=tx_data[i-1]; end
					4'd9:
					if(bpsclk) begin i<=i+1'b1;rTX<=1'b1; end
					4'd10:
					if(bpsclk) begin i<=i+1'b1;rTX<=1'b1; end
					4'd11:
					if(bpsclk) begin i<=i+1'b1;isDone<=1'b1; end
					4'd12:
					begin i<=4'd0;isDone<=1'b0; end
				endcase
		end
			
	assign tx_out=rTX;
	assign tx_stop=isDone;
	
endmodule