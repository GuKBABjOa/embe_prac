module counterN(clk, reset, en, qout, tc);
	parameter N = 10;
	localparam M = $clog2(N);
	input clk, reset, en;
	output reg [M-1:0] qout;
	output tc;
	always @(posedge clk) begin
		if (~reset) qout <= 0; 
		else if (en) begin
			if (qout == N-1) qout <= 0;
			else qout <= qout + 1;
		end
	end
	assign tc = en & (qout == N-1);
endmodule