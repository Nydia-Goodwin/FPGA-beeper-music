//Topmodule
module Final(clk,rst,tx_out,choose,row,column,seg,scan,piano_out,key,rx_in);
	input clk,rst,rx_in;
	input[1:0] choose;
	input[3:0] column;
	input[6:0] key;
	output[5:0] scan;
	output[7:0] seg;
	output[3:0] row;
 	output tx_out,piano_out;
	wire rx_stop;
	wire rx_en;
	wire[7:0] rx_data;	//这是串口传过来的量
	wire[7:0] out_data;	//这是输出给串口的量
	wire[3:0] num1,num2;	//这是由串口传给数码管的数
	wire[7:0] dataout;
	wire[7:0] tx_data;	//V1 to V2
	wire tx_en;	//V1 to V2
	wire tx_stop;	//V2 to V1

	assign num1={out_data[7],out_data[6],out_data[5],out_data[4]};
	assign num2=out_data[3:0];
	
	tx_ctrl V1(.clk(clk),.rst(rst),.tx_stop(tx_stop),.tx_en(tx_en),.tx_data(tx_data),.dataout(dataout));
	snddata V2(.clk(clk),.rst(rst),.tx_data(tx_data),.tx_en(tx_en),.tx_stop(tx_stop),.tx_out(tx_out),.choose(choose));
	keyboard4x4 V3(.row(row),.clk(clk),.start(rst),.column(column),.dout(dataout),.key(key));
	scan_led V4(.seg(seg),.scan(scan),.clk(clk),.datain(dataout),.num1(num1),.num2(num2));
	music V5(.clk(clk),.rst(rst),.datain(tx_data),.flag(piano_out));
	rcvdata V6(.clk(clk),.rst(rst),.rx_in(rx_in),.rx_en(rx_en),.rx_stop(rx_stop),.rx_data(rx_data),.choose(choose));
	rx_ctrl V7(.clk(clk),.rst(rst),.rx_stop(rx_stop),.rx_en(rx_en),.rx_data(rx_data),.number(out_data));
	
endmodule
