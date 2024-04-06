module mux2n(a, b, s, y);
	parameter N = 8;
	input [N-1:0] a, b;
	input s;
	output [N-1:0] y;
	
	assign y = s ? b : a;
endmodule