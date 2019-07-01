module rx_dis(clk,rst,rx_in,seg,scan,choose);
	input clk;
	input rst;
	input rx_in;
	input[1:0] choose;
	output[7:0] seg;
	output[5:0] scan;
	
	wire rx_stop;
	wire rx_en;
	wire[7:0] rx_data;	//这是个input量
	wire[7:0] out_data;	//这是输出量
	wire[3:0] num1,num2;	//传给数码管的数
	rcvdata V1(.clk(clk),.rst(rst),.rx_in(rx_in),.rx_en(rx_en),.rx_stop(rx_stop),.rx_data(rx_data),.choose(choose));
	rx_ctrl v2(.clk(clk),.rst(rst),.rx_stop(rx_stop),.rx_en(rx_en),.rx_data(rx_data),.number(out_data));
	assign num1={out_data[7],out_data[6],out_data[5],out_data[4]};
	assign num2=out_data[3:0];
/*	reg[3:0] tmp1,tmp2,datatmp1,datatmp2,datatmp3;
	always
		begin
			tmp1=num1;
			tmp2=num2;
			if(tmp1>=4'd10) 
				begin
					datatmp1=4'd1;
					if(tmp2>=4'd10) 
						datatmp2=tmp1-4'd10+4'd1;
					else
						datatmp2=tmp1-4'd10;
				end
			else 
				begin
					datatmp1=4'd0;
					if(tmp2>=4'd10) 
						datatmp2=tmp1+4'd1;
					else
						datatmp2=tmp1;
				end
			if(tmp2>=4'd10) 
				datatmp3=tmp2-4'd10;
			else 
				datatmp3=tmp2;
		end
	assign data1=datatmp1;
	assign data2=datatmp2;
	assign data3=datatmp3;
	*/
//	scan_led(.seg(seg),.scan(scan),.clk(clk),.data1(data1),.data2(data2),.data3(data3));
	scan_led(.seg(seg),.scan(scan),.clk(clk),.data1(num1),.data2(num2));
endmodule