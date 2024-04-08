/*
module D_FF (clk, reset, set, d, q, qbar);
	input clk, reset, set, d;
	output q, qbar;
	reg q;
	
	assign qbar = ~q;
	
	always @ (posedge clk) begin
		if (reset == 0) q <= 1'b0;
		else if (set == 0) q <= 1'b1;
		else q <= d;
	end
endmodule
*/
module D_FF (clk, reset, set, d, q, qbar);
	input clk, reset, set, d;
	output q, qbar;
	reg q;
	
	assign qbar = ~q;
	
	always @ (posedge clk, negedge reset, negedge set) begin
		if (reset == 0) q <= 0
		else if (set == 0) q <= 1
		else q <= d;
	end
endmodule