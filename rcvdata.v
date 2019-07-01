module rcvdata(clk,rst,rx_in,rx_en,rx_stop,rx_data,choose);
	input clk,rst;
	input rx_in,rx_en;
	input[1:0] choose;
	output[7:0] rx_data;
	output rx_stop;
	wire h2l;	//from U1 to U3
	wire bpsclk;	//from U2 to U3
	wire bpssrt;	//from U3 to U2
	
	detect U1(.clk(clk),.rst(rst),.rx_in(rx_in),.h2l(h2l));
	bps U2(.clk(clk),.rst(rst),.bpssrt(bpssrt),.bpsclk(bpsclk),.choose(choose));
	uart_rx U3(.clk(clk),.rst(rst),.h2l(h2l),.rx_in(rx_in),.bpsclk(bpsclk),.rx_en(rx_en),.bpssrt(bpssrt),.rx_data(rx_data),.rx_stop(rx_stop));
endmodule