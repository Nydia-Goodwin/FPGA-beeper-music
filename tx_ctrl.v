//串口通信控制模块
module tx_ctrl(clk,rst,tx_stop,tx_en,tx_data,dataout);
	input clk,rst;
	input tx_stop;
	input[7:0] dataout;
	output tx_en;
	output[7:0] tx_data;
	reg[24:0] cnt;
	always@(posedge clk or negedge rst)//控制上传时间的块
		begin
			if(!rst)
				cnt<=25'd0;
			else if(cnt==25'd5000000)
				cnt<=25'd0;
			else
				cnt<=cnt+1'b1;
		end
		
	reg isEn;
	reg[7:0] rDatar,datatmp;
	
	always@(posedge clk or negedge rst)
		begin
			if(!rst)
				begin
					isEn<=1'b0;
					rDatar<=8'b0;
				end
			else if(tx_stop)
				begin
					isEn<=1'b0;
					rDatar<=datatmp;
				end
			else if(cnt==25'd5000000)
				begin
					datatmp<=dataout;
					rDatar<=dataout;
					isEn<=1'b1;
				end
		end	
		
	assign tx_data=rDatar;
	assign tx_en=isEn;
endmodule
