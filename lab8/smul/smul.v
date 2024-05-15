module smul(clk, reset, start, word1, word2, product, ready);
	input clk, reset, start;
	input [3:0] word1, word2;
	output [7:0] product;
	output ready;
	wire m0; 
	wire load, shift, addshift; 
	wire sub; 
	
	
	reg [7:0] product;
	reg [3:0] multiplicand;
	wire[4:0] sum; // 5-bit
	wire[4:0] emcand, eprod;
	
	assign m0 = product[0];
	
	assign eprod = {product[7], product[7:4]}; 
	assign emcand = {multiplicand[3],multiplicand}; 
	assign sum = sub ? (eprod - emcand) : (eprod + emcand);
	
	always @ (posedge clk) begin
		if (load) begin
			multiplicand <= word1;
			product <= {4'b0, word2}; 
		end
		else if (addshift) product <= {sum, product[3:1]};
		else if (shift) product <= {product[7], product[7:1]}; 
	end
	
	
	localparam S0=0, S1=1;
	reg state;
	reg [1:0] count;
	
	always @ (posedge clk, negedge reset) 
		if (~reset) state <= S0;
		else
			case (state)
			S0: if (start) begin state <= S1; count <= 3; end
			S1: if (count==0) state <= S0;
			else count <= count - 1;
			endcase
	
	assign load = (state==S0) && start;
	assign shift = (state==S1) && ~m0;
	assign addshift = (state==S1) && m0;
	assign ready = (state==S0) && reset;
	assign sub = (state==S1) && (count==0); 
endmodule