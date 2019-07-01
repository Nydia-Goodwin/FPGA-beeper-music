module scan_led(seg,scan,clk,datain,num1,num2);
	input clk;//板载时钟
	input[7:0] datain;//读入数据
	output[7:0] seg;//段选控制信号
	output[5:0] scan;//位选控制信号
	reg[7:0] seg;
	reg[5:0] scan;
	reg[2:0] cnt6=0;//位选控制变量
	reg cp=0;//控制数码管闪烁频率的时钟
	reg[20:0] div=0; //时钟分频
	reg[3:0] data,data1,data2;
	input[3:0] num1,num2;
	always@(posedge clk)
		begin
			data1<=datain;
			data2<={datain[7],datain[6],datain[5],datain[4]};
		end
		
	always @(posedge clk)
		begin
			div=div+1;
			if(div==21'd25000)
			begin
				cp=~cp;
				div=0;
			end
		end

	always @(posedge cp)
		begin
			cnt6=cnt6+1;
			if(cnt6==3'd6) cnt6=0;
		end
		
	always @(posedge cp)
		begin
			case(cnt6[2:0])
			3'b000: begin scan<='b111110;data<=data1;end
			3'b001: begin scan<='b111101;data<=data2;end
			3'b100: begin scan<='b111011;data<=num2;end
			3'b101: begin scan<='b110111;data<=num1;end
			default: scan<='b111111;
			endcase
		end
		
/*	always @(posedge cp)
		begin
			cnt6=cnt6+1;
			if(cnt6==3'd6) cnt6=0;
		end
		
	always @(posedge cp)
		begin
			case(cnt6[2:0])
			3'b000: begin scan<='b111110;data[3:0]<=data6;end
			3'b001: begin scan<='b111101;data[3:0]<=data5;end
			3'b010: begin scan<='b111011;data[3:0]<=data4;end
			3'b011: begin scan<='b110111;data[3:0]<=data3;end
			3'b100: begin scan<='b101111;data[3:0]<=data2;end
			3'b101: begin scan<='b011111;data[3:0]<=data1;end
			default: scan<='b111111;
			endcase
		end
*/		
	always
		begin
				case(data[3:0])
					4'b0000:seg[7:0]<=8'b00000011;//0
					4'b0001:seg[7:0]<=8'b10011111;//1
					4'b0010:seg[7:0]<=8'b00100101;//2
					4'b0011:seg[7:0]<=8'b00001101;//3
					4'b0100:seg[7:0]<=8'b10011001;//4
					4'b0101:seg[7:0]<=8'b01001001;//5
					4'b0110:seg[7:0]<=8'b01000001;//6
					4'b0111:seg[7:0]<=8'b00011111;//7
					4'b1000:seg[7:0]<=8'b00000001;//8
					4'b1001:seg[7:0]<=8'b00001001;//9
					4'b1010:seg[7:0]<=8'b00010001;//a
					4'b1011:seg[7:0]<=8'b11000001;//b
					4'b1100:seg[7:0]<=8'b01100011;//c
					4'b1101:seg[7:0]<=8'b10000101;//d
					4'b1110:seg[7:0]<=8'b01100001;//e
					4'b1111:seg[7:0]<=8'b01110001;//f
					default:seg[7:0]<=8'b11111111;
				endcase
		end

endmodule			