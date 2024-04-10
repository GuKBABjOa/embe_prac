/*
module majority (data, y);
	input [3:0] data;
	output y;
	reg y;
	
	always @ (*) begin
		case (data)
			7, 11, 13, 14: y = 1;
			15: y = 1;
			default: y = 0;
		endcase
	end
endmodule
*/
module majority(data, y);
	parameter SIZE = 4;
	localparam MAJORITY = SIZE/2 + 1;
	input [SIZE-1: 0] data;
	output y;
	reg y;
	
	integer count, k;
	
	always @ (data) begin
		count = 0;
		for (k = 0; k < SIZE; k = k + 1) begin
			if (data[k]) count = count + 1;
		end
		y = count >= MAJORITY;
	end
endmodule
