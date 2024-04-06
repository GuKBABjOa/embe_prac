module	comparator(a,	b,	lt,	gt,	eq);
	input	a,	b;
	output	lt,	gt,	eq;
	assign lt = ~a & b;
	assign gt = a & ~b;
	assign eq = ~a & ~b | a & b;	
endmodule