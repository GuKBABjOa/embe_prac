`timescale 1ns / 1ps


module fulladder_tb;
	reg a, b, c;
	wire sum, cout;
	wire s, c1, c2;
	
	halfadder u1 (a, b, s, c1);
	halfadder u2 (c, s, sum, c2);
	or u3 (cout, c1, c2);
	
	initial begin
		$monitor("%10d : %b %b %b : %b %b", $time, a, b, c, cout, sum);
		#200 $stop;
	end
	
	initial begin
		#20 a = 0; b = 0; c = 0;
		#20 c = 1;
		#20 b = 1;
		#20 c = 0;
		#20 a = 1;
		#20 c = 1;
		#20 b = 0;
		#20 c = 0;
	end
endmodule