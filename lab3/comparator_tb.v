`timescale 1ns / 1ps


module comparator_tb;
	reg a, b;
	wire lt, gt, eq;
	
	comparator u1 (a,	b,	lt,	gt,	eq);
	
	initial #100 $stop;
	
	initial begin
		a = 0;
		#25 a = 0;
		#25 a = 1;
		#25 a = 1;
		
	end
	initial begin
		b = 0;
		#25 b = 1;
		#25 b = 0;
		#25 b = 1;

	end
endmodule