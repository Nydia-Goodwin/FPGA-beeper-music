//蜂鸣器控制模块
//调节频率控制音调，调节小占空比减小噪声
module music(clk,rst,datain,flag);
	input	clk;		//系统时钟
	input	rst;	//系统复位，低有效
	input[7:0]	datain;		//蜂鸣器音节控制
//	output reg	piano_out;	//蜂鸣器控制输出
	reg[17:0] origin,bw;
	reg[17:0] div;
	reg[3:0] tone;
	output reg flag;
	
always@(posedge clk)
	tone<=datain;
	
always@(posedge clk or negedge rst)
	begin
		if(!rst)
			begin
				div<=0;
				flag<=1;
			end
		else
			begin
				if(div==18'd262143)
					begin
						div<=origin;
						flag<=0;
					end
				else
					begin
						div<=div+1'b1;
						if(div>bw)
							flag<=1;
						else flag<=0;
					end
			end
		end

always@(tone) 
	begin
		case(tone)
			4'd1:begin origin<=18'd71079;bw<=18'd80626; end	//M1,bw=timedelay/10=19106
			4'd2:begin origin<=18'd91895;bw<=18'd99478; end	//M2,bw=17024
			4'd3:begin origin<=18'd110479;bw<=18'd117636; end	//M3,bw=15166
			4'd4:begin origin<=18'd118995;bw<=18'd126152; end	//M4,bw=14315
			4'd5:begin origin<=18'd134611;bw<=18'd140987; end	//M5,bw=12753
			4'd6:begin origin<=18'd148527;bw<=18'd154208; end	//M6,bw=11362
			4'd7:begin origin<=18'd160927;bw<=18'd165988; end	//M7,bw=10122
			4'd9:begin origin<=18'd166479;bw<=18'd171262; end	//L1,bw=9566
			4'd10:begin origin<=18'd177027;bw<=18'd181282; end	//L2,bw<=18'd8510;
			4'd11:begin origin<=18'd186327;bw<=18'd190117; end	//L3,bw<=18'd7580;
			4'd12:begin origin<=18'd190579;bw<=18'd194149; end	//L4,bw<=18'd7140;
			4'd13:begin origin<=18'd198395;bw<=18'd201575; end	//L5,bw<=18'd6360;
			4'd14:begin origin<=18'd205343;bw<=18'd208183; end	//L6,bw<=18'd5680;
			4'd15:begin origin<=18'd211543;bw<=18'd214073; end	//L7,bw<=18'd5060;
			default:begin origin<=18'd262142;bw<=18'd0; end	//休止符
	endcase
end
 
endmodule