`timescale 1ns / 1ps

module halfadder_tb;
	reg a,b;
	wire sum, cout;
	
	halfadder u1 (a, b, sum, cout);
	
	initial begin
		$monitor("%10d : %b %b : %b %b", $time, a, b, cout, sum);
		#100 $stop;
	end
	
	initial begin
		#20 a = 0; b = 0;
		#20 b = 1;
		#20 a = 1;
		#20 b = 0;
	end
endmodule