module mult(clk, reset, start, word1, word2, product, ready);
	input clk, reset, start;
	input [3:0] word1, word2;
	output [7:0] product;
	output ready;
	wire m0; 
	wire load, shift, addshift;
	wire sub;
	input sig;
	
	reg [7:0] product;
	reg [3:0] multiplicand;
	wire[4:0] sum;
	wire[4:0] emcand, eprod;
	always @ (posedge clk) begin
		if(~sig) begin
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
		end
		else if(sig) begin
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
			
			
			S0=0;
			S1=1;
			reg state1;
			reg [1:0] count;
			
			always @ (posedge clk, negedge reset) 
				if (~reset) state1 <= S0;
				else
					case (state1)
					S0: if (start) begin state1 <= S1; count <= 3; end
					S1: if (count==0) state1 <= S0;
					else count <= count - 1;
					endcase
			
			assign load = (state1==S0) && start;
			assign shift = (state1==S1) && ~m0;
			assign addshift = (state1==S1) && m0;
			assign ready = (state1==S0) && reset;
			assign sub = (state1==S1) && (count==0); 
		end
	end
endmodule
