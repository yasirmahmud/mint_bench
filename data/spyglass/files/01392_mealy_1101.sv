module mealy_1101(Clk,Rst,Din,Y);
	input Clk,Rst;
	input Din;
	output reg Y;
	reg [1:0] curr_state;
	reg [1:0] next_state;
	parameter s0 = 2'b00;
	parameter s1 = 2'b01;
	parameter s2 = 2'b10;
	parameter s3 = 2'b11;
// Sequential Block
	always @(posedge Clk)
	begin
		if(Rst)
			begin
				curr_state <= s0;
				Y <= 1'b0;
			end
		else
			begin
				curr_state <= next_state;
			end
	end
// Combinational Block
	always @(curr_state or Din)
	begin
		case (curr_state)
		s0 : begin
				if(Din)
					begin
						Y = 1'b0;
						next_state = s1;
					end
				else
					begin
						Y = 1'b0;
						next_state = s0;
					end
			end
		s1 : begin
				if(Din)
					begin
						Y = 1'b0;
						next_state = s2;
					end
				else
					begin
						Y = 1'b0;
						next_state = s0;
					end
			end
		s2 : begin
				if(Din)
					begin
						Y = 1'b0;
						next_state = s2;
					end
				else
					begin
						Y = 1'b0;
						next_state = s3;
					end
			end
		s3 : begin
				if(Din)
					begin
						Y = 1'b1;
						next_state = s1;
					end
				else
					begin
						Y = 1'b0;
						next_state = s0;
					end
			end
		default : begin
					Y = 1'b0;
					next_state = s0;
				end
		endcase
	end
endmodule
