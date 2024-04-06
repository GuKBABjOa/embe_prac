module	comparatorN(a,	b,	lt,	gt,	eq);
	parameter	N=8;
	input	[N-1:0]	a,	b;
	output	lt,	gt,	eq;
	
	assign lt = a < b;
	assign gt = a > b;
	assign eq = a == b;
endmodule