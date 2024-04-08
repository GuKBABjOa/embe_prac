/*
module shift4(clk, a, b, c, d, e);
	input clk;
	input a;
	output reg b, c, d, e;
	
	always @(posedge clk) begin
		b = a;
		c = b;
		d = c;
		e = d;
	end
endmodule
*/
/*
module shift4(clk, a, b, c, d, e);
	input clk;
	input a;
	output reg b, c, d, e;
	
	always @(posedge clk) begin
		b <= a;
		c <= b;
		d <= c;
		e <= d;
	end
endmodule
*/
module shift4(clk, a, b, c, d, e);
	input clk;
	input a;
	output reg b, c, d, e;
	
	always @(posedge clk)
		{b, c, d, e} <= {a, b, c ,d};
endmodule
