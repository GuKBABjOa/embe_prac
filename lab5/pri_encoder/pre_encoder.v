/*
module pre_encoder(data, code, valid);
	input [3:0] data;
	output reg [1:0] code;
	output valid;
	
	always @(*) begin
		if (data[0]) code = 0;
		else if (data[1]) code = 1;
		else if (data[2]) code = 2;
		else if (data[3]) code = 3;
		else code = 2'bx;
		
	end
	assign valid = |data;
endmodule
*/
module pre_encoder(data, code, valid);
	input [3:0] data;
	output reg [1:0] code;
	output valid;
	
	always @(*) begin
		casex (data)
			4'bxxx1: code = 0;
			4'bxx10: code = 1;
			4'bx100: code = 2;
			4'b1000: code = 3;
			default: code = 2'bx;
		endcase
		
	end
	assign valid = (data != 0);
endmodule