//串口通信模块
module snddata(clk,rst,tx_data,tx_en,tx_stop,tx_out,choose);
	input clk,rst;
	input[7:0] tx_data;
	input tx_en;
	input[1:0] choose;
	output tx_stop;
	output tx_out;
	
	wire bpsclk;
	bps V1(.clk(clk),.rst(rst),.bpssrt(tx_en),.bpsclk(bpsclk),.choose(choose));
	uart_tx V2(.clk(clk),.rst(rst),.tx_en(tx_en),.tx_data(tx_data),.bpsclk(bpsclk),.tx_stop(tx_stop),.tx_out(tx_out));
endmodule
