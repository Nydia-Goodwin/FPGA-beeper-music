module rx_ctrl(clk,rst,rx_stop,rx_en,rx_data,number);
	input clk,rst;
	input rx_stop;
	input[7:0] rx_data;
	output rx_en;
	output[7:0] number;
	
	reg[7:0] rData;
	reg isEn;
	always@(posedge clk or negedge rst)
		if(!rst)
			rData<=8'd0;
		else if(rx_stop)
			begin
				rData<=rx_data;
				isEn<=1'b0;
			end
		else
			isEn<=1'b1;
	assign number=rData;
	assign rx_en=isEn;
endmodule
	