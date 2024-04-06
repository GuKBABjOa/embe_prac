`timescale 1ns / 1ps
module halfadder(a, b, sum, cout);
	input a, b;
	output sum, cout;
	
	xor #4 u1 (sum, a, b);
	and #2 u2 (cout, a, b);
endmodule
