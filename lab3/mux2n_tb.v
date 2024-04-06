`timescale 1ns / 1ps


module mux2n_tb;
	reg [3:0] a, b;
	reg sel;
	wire [3:0] out;
	
	mux2n #(4) u1 (a, b, sel, out);
	
	initial #100 $stop;
	
	initial begin
		a = 0;
		#20 a = 2;
		#20 a = 4;
		#20 a = 8;
		#20 a = 10;
	end
	initial begin
		b = 5;
		#10 b = 7;
		#20 b = 9;
		#20 b = 11;
		#20 b = 13;
	end
	initial begin
		sel = 0;
		#45 sel = 1;
	end
endmodule