module mux2(a, b, s, y);
	input [3:0] a, b;
	input s;
	output [3:0] y;

	assign y = s ? b : a;
endmodule