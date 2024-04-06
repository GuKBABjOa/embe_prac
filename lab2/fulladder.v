module fulladder(a, b, c, sum, cout);
	input a, b, c;
	output sum, cout;
	wire s, c1, c2;
	
	halfadder u1 (a, b, s, c1);
	halfadder u2 (c, s, sum, c2);
	or u3 (cout, c1, c2);
endmodule
