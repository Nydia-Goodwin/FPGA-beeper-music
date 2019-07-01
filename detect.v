//检测下降沿判断串口开始接收数据（相对FPGA开发板而言）
module detect(clk,rst,rx_in,h2l);
    input clk;
	 input rst;
	 input rx_in;
	 output h2l;
//下面是检测下降沿并生成正脉冲h2l 
	 reg h2l1,h2l2;
	 always@(posedge clk or negedge rst)
	     if(!rst)
		      begin
				    h2l1<=1'b1;
					 h2l2<=1'b1;
				end
		  else
		      begin
				    h2l1<=rx_in;
					 h2l2<=h2l1;
				end
	assign h2l=h2l2&&(!h2l1);
endmodule


	 