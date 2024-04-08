/*
module d_latch(en, din, qout);
	input en, din;
	output qout;
	
	assign qout = en ? din : qout;
endmodule
*/
module d_latch(en, din, qout);
	input en, din;
	output qout;
	reg qout;
	
	always @(en, din)
		if(en) qout = din;
	
endmodule
