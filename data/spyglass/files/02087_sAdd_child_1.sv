module sAdd( ain, bin, reset_n, clk, start, sum, done);
	parameter N = 8;
	input [N-1:0] ain, bin;
	input reset_n, clk, start;
	output reg done;
	output reg [N-1:0] sum;

	// Counter size adjusted to hold N (for N shifts).
	// For N=8, $clog2(8) is 3, so `reg [3:0]` is needed to count from 8 down to 1.
	reg [$clog2(N):0] counter;
	reg [1:0] state;
	reg [N-1:0] ain_reg, bin_reg;

	wire [N-1:0] A_reg, B_reg, sum_reg;
	localparam S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

	// Instantiate all the components
	// fin_a, fin_b, and sum_in changed to wires as they are combinational or tied values.
	wire fin_a, fin_b;
	reg s_reset; // Renamed from 'reset' and made synchronous for sub-modules
	reg load_a, load_b, load_s, shiftR, lin;
	wire dff_in;
	wire dff_out, f_cout;
	wire f_out;
	wire [N-1:0] sum_in; // sum_in is parallel load data for sum_reg, tied to 0

	// Combinational assignments
	assign dff_in = f_cout; // D-input to carry flip-flop
	assign fin_a = A_reg[0]; // LSB of Ain_reg (output from shiftre)
	assign fin_b = B_reg[0]; // LSB of Bin_reg (output from shiftre)
	assign sum_in = {N{1'b0}}; // sum_in is parallel load data for sum_reg, always 0 for this design

	fulladder FA(fin_a, fin_b, dff_out, f_out, f_cout);

	// Using s_reset for sub-module resets
	shiftre regA(ain_reg, load_a, shiftR, lin, clk, s_reset, A_reg);
	shiftre regB(bin_reg, load_b, shiftR, lin, clk, s_reset, B_reg);
	shiftre regsum(sum_in, load_s, shiftR, f_out, clk, s_reset, sum_reg ); // f_out is serial input `lin`
	dff flipflop(dff_in, s_reset, clk, dff_out);

	always @(posedge clk) begin
		if (!reset_n) begin // Asynchronous reset for the FSM and its registers
			state <= S0;
			done <= 1'b0;
			counter <= {($clog2(N)+1){1'b0}}; // Reset counter to 0
			ain_reg <= {N{1'b0}};
			bin_reg <= {N{1'b0}};
			load_a <= 1'b0;
			load_b <= 1'b0;
			load_s <= 1'b0;
			shiftR <= 1'b0;
			lin <= 1'b0;
			s_reset <= 1'b1; // Assert synchronous reset for sub-modules
		end else begin // Synchronous logic
			// Default assignments to prevent latches and provide known values
			load_a <= 1'b0;
			load_b <= 1'b0;
			load_s <= 1'b0;
			shiftR <= 1'b0;
			lin <= 1'b0;
			done <= 1'b0; // 'done' is only 1 in S3
			s_reset <= 1'b0; // De-assert synchronous reset by default

			case(state) // FSM state transitions
				S0 : begin
					if(start) begin
						state <= S1;
						// All other signals keep their default de-asserted values
					end
					// else, state remains S0, signals remain default
				end
				S1 : begin
					s_reset <= 1'b1; // Assert synchronous reset for sub-modules (as per original `reset = 1;`)
					ain_reg <= ain;
					bin_reg <= bin;
					load_a <= 1'b1; // Load Ain and Bin into shift registers
					load_b <= 1'b1;
					counter <= N; // Initialize counter for N shifts
					state <= S2;
					end
				S2 : begin
					// s_reset is 0 (de-asserted) by default
					// load_a, load_b are 0 (de-asserted) by default
					if(counter != {($clog2(N)+1){1'b0}}) begin // Check if counter is not 0
						shiftR <= 1'b1; // Start shifting
						counter <= counter - 1;
						// fin_a and fin_b are wires, updated combinatorially.
						// sum_in is a wire, tied to 0.
						state <= S2;
					end
					else begin
						shiftR <= 1'b0; // Stop shifting
						state <= S3;
						end
				end
				S3 : begin
					done <= 1'b1;
					sum <= sum_reg; // Output the final sum
					state <= S0; // Go back to idle state
					end
			endcase
		end
	end
endmodule
