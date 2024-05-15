module mul(clk, reset, start, word1, word2, product, ready);
	input clk, reset, start;
	input [3:0] word1, word2;
	output [7:0] product;
	output ready;
	wire m0; 
	wire load, shift, addshift;
	
	reg [7:0] product;
	reg [3:0] multiplicand;
	wire[4:0] sum;
	
	assign m0 = product[0];
	assign sum = product[7:4] + multiplicand;
	
	always @ (posedge clk) begin
		if (load) begin
			multiplicand <= word1;
			product <= {4'b0, word2};
		end
		else if (addshift) product <= {sum, product[3:1]};
		else if (shift) product <= {1'b0, product[7:1]};
	end
	
	localparam S0=0,S1=4,S3=5,S5=6,S7=7;
	reg [2:0] state;
	
	always @ (posedge clk, negedge reset) 
		if (~reset) state <= S0;
		else
			case (state)
				S0: if(start) state <= S1;
				S1: state <= S3;
				S3: state <= S5;
				S5: state <= S7;
				S7: state <= S0;
			endcase
			
	assign load = (state==S0) && start;
	assign shift = (state==S1||state==S3||state==S5||state==S7) && ~m0;
	assign addshift = (state==S1||state==S3||state==S5||state==S7) && m0;
	assign ready = (state==S0) && reset;

endmodule
