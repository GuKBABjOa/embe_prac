module clk1hz(CLK50, clk);
	input CLK50; // 50 MHz clock;
	output clk; // 1 Hz clock
	wire tc;
	reg clk;
	
	counterN #(25_000_000) u1 (.clk(CLK50), .reset(1), .en(1), .tc(tc));
	
	always @(posedge CLK50)
		if (tc) clk = ~clk;
endmodule
