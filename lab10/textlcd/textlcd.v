module textlcd(CLOCK_50, KEY, SW,LCD_RS, LCD_RW, LCD_EN, LCD_DATA, LCD_ON, LCD_BLON);
	input CLOCK_50; 
	input [3:0] KEY; 
	input [7:0] SW;
	output LCD_RS, LCD_RW, LCD_EN;
	output [7:0] LCD_DATA;
	output LCD_ON, LCD_BLON;
	wire start, RS, done;
	wire [7:0] data;
	wire CS = 1'b1;
	wire clk_50 = CLOCK_50;
	wire reset = ~KEY[0];
	lcd_test u1 (clk_50, reset, SW[7:0] ,start, RS, data, done);
	lcd_controller u2 (clk_50, reset, start, CS, RS, data, done, LCD_RS, LCD_RW, LCD_EN, LCD_DATA);
	assign LCD_ON = 1'b1;
	assign LCD_BLON = 1'b1;
endmodule
module lcd_controller(clk, reset, start, CS, RS, data, done, LCD_RS, LCD_RW, LCD_E, LCD_data);
	
	input clk; 
	input reset, start;
	input CS, RS;
	input [7:0] data;
	output done;
	
	output LCD_RS, LCD_RW, LCD_E;
	output [7:0] LCD_data;
	reg [2:0] state;
	reg [3:0] count;
	localparam S0=0, S1=1, S2=2, S3=4, S4=3;
	localparam PW_E = 12; 
	assign LCD_RS = RS; 
	assign LCD_RW = 1'b0; 
	assign LCD_data = data; 
	always @(posedge clk or posedge reset) begin
	if (reset) state <= S0;
	else
		case (state)
			S0: if (start & CS) state <= S1;
			S1: state <= S2;
			S2: begin state <= S3; count <= PW_E - 1; end
			S3: if (count == 0) state<= S4;
			else count <= count - 1;
			S4: state <= S0;
			default: state <= S0;
		endcase
	end
	assign LCD_E = (state==S3);
	assign done = (state==S4);
endmodule

module lcd_test(clk, reset, SW,start, RS, data, done);
	input clk;
	input reset;
	input [7:0] SW;
	output start, RS;
	output [7:0] data;
	input done;

	reg [5:0] index;
	reg [7:0] data;
	reg [1:0] state;
	reg [17:0] count;
	reg RS, halt, jump;
	wire start;

	localparam DELAY = 4_100_000 / 20;
	localparam INIT = 0;
	localparam LINE1 = INIT + 4;
	localparam LINE2 = LINE1 + 2;
	localparam LAST = LINE2 + 2;
	localparam S0=0, S1=1, S2=2, S3=3;
	always @(posedge clk or posedge reset) begin
		 if (reset) begin
			  state <= S0;
			  count <= 0;
			  index <= INIT;
		 end
		 else begin
			  case (state)
					S0: if (~halt) state <= S1;
					S1: state <= S2;
					S2: if (done) begin
						 state <= S3;
						 if(jump) index <= LINE1;
						 else index <= index + 1;
						 count <= DELAY;
					end
					S3: if (count == 0) state <= S0;
						 else count <= count - 1;
					default: state <= S0;
			  endcase
		 end
	end

	assign start = (state == S1);
	always @* begin
		 data = 8'b0;
		 halt = 0; jump = 0;
		 RS = 1;
		 case (index)
			  INIT:       begin data = 8'b0011_1100; RS = 0; end
			  INIT+1:     begin data = 8'b0000_1100; RS = 0; end
			  INIT+2:     begin data = 8'b0000_0110; RS = 0; end
			  INIT+3:     begin data = 8'b0000_0001; RS = 0; end
			  
			  LINE1:      begin data = 8'b1000_0000; RS = 0; end
			  LINE1+1:    data = (SW[7:4]< 10)?{4'b0011,SW[7:4]} : "*";
			  
			  LINE2:      begin data = 8'b1100_0000; RS = 0; end
			  LINE2+1:    begin data = (SW[3:0]< 10)?{4'b0011,SW[3:0]} : "*"; jump = 1;end
			  
			  
			  LAST:       halt = 1;
			  default:    halt = 1;
		 endcase
	end
endmodule
