module sdiv(clk, reset, start, word1, word2, quotient, remainder, ready);
	input clk, reset, start;
	input [7:0] word1;
	input [3:0] word2;
	output [3:0] quotient, remainder;
	output ready;
	wire load, shift, subshift, sub; 
	wire lt;
	
	reg [7:0] dividend; 
	reg [3:0] divisor; 
	reg sign; 
	wire [4:0] diff, edivisor; 
	
	assign edivisor = {divisor[3], divisor}; 
	assign diff = (dividend[7]^divisor[3]) ? (dividend[7:3] + edivisor)
						: (dividend[7:3] - edivisor);
	assign lt = (dividend[7]^diff[4]) && (diff != 4'b0); 
	
	always @ (posedge clk) begin
		if (load) begin
			dividend <= word1; divisor <= word2;
			sign <= word1[7] ^ word2[3];
			end
		else if (shift) dividend <= {dividend[6:0], 1'b0}; 
		else if (subshift) dividend <= {diff[3:0], dividend[2:0], 1'b1}; 
	end
	
	assign quotient = sign ? -dividend[3:0] : dividend[3:0];
	assign remainder = dividend[7:4];
	
	reg overflow;
	reg state;
	localparam S0 = 0, S1 = 1;
	reg [1:0] count;
	always @ (posedge clk, negedge reset) 
		if (~reset) begin state <= S0; count <= 0; end
		else
			case (state)
				S0: if (start) begin state <= S1; count <= 3; end
				S1: if (count==0) state <= S0;
			else count <= count - 1;
		endcase
	
	
	assign load = (state==S0) && start;
	assign shift = (state==S1) && lt;
	assign subshift = (state==S1) && ~lt;
	assign ready = (state==S0) && reset;
endmodule