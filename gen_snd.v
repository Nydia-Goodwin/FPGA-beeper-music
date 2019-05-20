//topmodule，键盘键入数据发送到串口，数码管上显示，蜂鸣器响特定音调
module gen_snd(clk,rst,tx_out,choose,row,column,seg,scan,piano_out);
	input clk,rst;
	input[1:0] choose;
	input[3:0] column;
	output[5:0] scan;
	output[7:0] seg;
	output[3:0] row;
 	output tx_out,piano_out;
	wire[7:0] dataout;
	wire[7:0] tx_data;	//V1 to V2
	wire tx_en;	//V1 to V2
	wire tx_stop;	//V2 to V1

	tx_ctrl V1(.clk(clk),.rst(rst),.tx_stop(tx_stop),.tx_en(tx_en),.tx_data(tx_data),.dataout(dataout));
	snddata V2(.clk(clk),.rst(rst),.tx_data(tx_data),.tx_en(tx_en),.tx_stop(tx_stop),.tx_out(tx_out),.choose(choose));
	keyboard4x4 V3(.row(row),.clk(clk),.start(rst),.column(column),.dout(dataout));
	scan_led V4(.seg(seg),.scan(scan),.clk(clk),.datain(dataout));
	music V5(.clk(clk),.rst(rst),.datain(tx_data),.flag(piano_out));
endmodule
