module crc16ccitt
(
	input wire i_clock,
	input wire i_nreset,
	input wire i_start,
	input wire i_data,
	output wire o_valid,
	output reg [15 : 0] o_r
);

localparam idle = 1'b0;
localparam active = 1'b1;

reg state_reg; // Current state register
reg state_next; // Next state combinational logic

reg [5 : 0] count_reg; // Current count register
reg [5 : 0] count_next; // Next count combinational logic

reg [15 : 0] o_r_next; // Next o_r combinational logic

// Sequential block for register updates with asynchronous reset
always @(posedge i_clock or negedge i_nreset) begin
	if (!i_nreset) begin
		state_reg <= idle;
		count_reg <= 6'd47;   // Initialize count to 47
		o_r <= 16'hFFFF;     // Initialize o_r
	end
	else begin // Synchronous updates
		state_reg <= state_next;
		count_reg <= count_next;
		o_r <= o_r_next;
	end
end

// Combinational block for next-state, next-count, and next-o_r logic
always @(*) begin
	// Default assignments: retain current values unless overridden
	state_next = state_reg;
	count_next = count_reg;
	o_r_next = o_r;

	case (state_reg)
		idle: begin
			if (i_start) begin
				state_next = active;
				count_next = 6'd47;   // Reset count for new calculation
				o_r_next = 16'hFFFF; // Reset CRC for new calculation
			end else begin
				state_next = idle;   // Remain in idle
				count_next = 6'd47;   // Continue to reset count in idle state
				o_r_next = 16'hFFFF; // Continue to reset o_r in idle state
			end
		end

		active: begin
			// CRC computation: Assuming '+' means XOR for GF(2) operations
			wire fb_bit = o_r[15] ^ i_data; // Feedback bit

			// Shift and XOR with feedback
			o_r_next[15 : 13] = o_r[14 : 12];
			o_r_next[12] = o_r[11] ^ fb_bit; // Tap at x^12
			o_r_next[11 : 6] = o_r[10 : 5];
			o_r_next[5] = o_r[4] ^ fb_bit;   // Tap at x^5
			o_r_next[4 : 1] = o_r[3 : 0];
			o_r_next[0] = fb_bit;            // Tap at x^0 (constant 1)

			count_next = count_reg - 1;

			// State transition condition
			state_next = (count_reg == 1) ? idle : active;
		end
		default: begin
			// Should not happen for a 2-state FSM, but good practice
			state_next = idle;
			count_next = 6'd47;
			o_r_next = 16'hFFFF;
		end
	endcase
end

// Output assignment
assign o_valid = (count_reg == 0); // Valid when calculation is complete (count reaches 0)

endmodule
