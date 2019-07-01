//蜂鸣器控制模块
//调节频率控制音调，调节小占空比减小噪声
module music(clk,rst,datain,flag);
	input	clk;		//系统时钟
	input	rst;	//系统复位，低有效
	input[7:0]	datain;		//蜂鸣器音节控制
	reg[17:0] origin,bw;
	reg[17:0] div;
	reg[6:0] tone;
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
			6'h01:begin origin<=18'd71079;bw<=18'd75849; end	//L1,bw=timedelay/10=19106
			6'h02:begin origin<=18'd91895;bw<=18'd95222; end	//L2,bw=17024
			6'h03:begin origin<=18'd110479;bw<=18'd113844; end	//L3,bw=15166
			6'h04:begin origin<=18'd118995;bw<=18'd122573; end	//L4,bw=14315
			6'h05:begin origin<=18'd134611;bw<=18'd137799; end	//L5,bw=12753
			6'h06:begin origin<=18'd148527;bw<=18'd151367; end	//L6,bw=11362
			6'h07:begin origin<=18'd160927;bw<=18'd163457; end	//L7,bw=10122
			6'h11:begin origin<=18'd166479;bw<=18'd168870; end	//M1,bw=9566
			6'h12:begin origin<=18'd177027;bw<=18'd179154; end	//M2,bw=8510;
			6'h13:begin origin<=18'd186327;bw<=18'd188222; end	//M3,bw=7580;
			6'h14:begin origin<=18'd190579;bw<=18'd192364; end	//M4,bw=7140;
			6'h15:begin origin<=18'd198395;bw<=18'd199985; end	//M5,bw=6360;
			6'h16:begin origin<=18'd205343;bw<=18'd206763; end	//M6,bw=5680;
			6'h17:begin origin<=18'd211543;bw<=18'd212808; end	//M7,bw=5060;
			6'h21:begin origin<=18'd214360;bw<=18'd215554; end	//H1,bw=4778;
			6'h22:begin origin<=18'd219576;bw<=18'd220640; end	//H2,bw=4256;
			6'h23:begin origin<=18'd224243;bw<=18'd225190; end	//H3,bw=3790;
			6'h24:begin origin<=18'd226343;bw<=18'd227238; end	//H4,bw=3580;
			6'h25:begin origin<=18'd230259;bw<=18'd231056; end	//H5,bw=3188;
			6'h26:begin origin<=18'd233736;bw<=18'd234446; end	//H6,bw=2842;
			6'h27:begin origin<=18'd236826;bw<=18'd237459; end	//H7,bw=2532;
			default:begin origin<=18'd262142;bw<=18'd0; end	//休止符
	endcase
end
 
endmodule