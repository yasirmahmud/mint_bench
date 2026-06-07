// Defines the addition_normaliser module.
// This module normalizes the mantissa by shifting left until bit 23 is 1 (for normal numbers)
// and adjusts the exponent accordingly. Handles zero/denormal results on exponent underflow.
module addition_normaliser (
	input [7:0] in_e,
	input [24:0] in_m, // in_m[24] should be 0 by this point, as overflow is handled upstream
	output reg [7:0] out_e,
	output reg [24:0] out_m
);

	always @(*) begin
		integer shift_val; // Declare loop variable inside always block for Verilog-2001 compliance

		out_e = in_e; // Default assignment to prevent latch inference
		out_m = in_m; // Default assignment to prevent latch inference
		shift_val = 0; // Default assignment

		if (in_m == 25'b0) begin
			// If mantissa is zero, the result is a floating-point zero
			out_e = 8'b0;
			out_m = 25'b0;
		end else if (in_m[23] == 1) begin
			// Mantissa is already normalized (implicit '1' at bit 23 is present).
			// No shifts or exponent adjustments are needed; out_e and out_m retain their default values.
		end else begin
			// Mantissa needs to be shifted left to normalize it.
			// Find the most significant '1' bit's position relative to bit 23.
			// Iterate from bit 22 down to 0 to find the highest set bit.
			for (shift_val = 0; shift_val < 24; shift_val = shift_val + 1) begin
				if (in_m[23 - shift_val] == 1) begin
					break; // Found the MSB, 'shift_val' now holds the number of positions to shift left.
				end
			end

			// Perform the shift and adjust the exponent.
			if (shift_val > 0) begin
				out_m = in_m << shift_val;
				if (in_e >= shift_val) begin // Check if the exponent can accommodate the left shift.
					out_e = in_e - shift_val;
				end else begin
					// Exponent underflow: the result becomes denormalized or zero.
					// We shift the mantissa by 'in_e' bits (the original exponent value)
					// to bring the effective exponent to zero, forming a denormalized number.
					out_m = in_m << in_e; 
					out_e = 8'b0;
				end
			end
			// If shift_val is 0 at this point, it means in_m[23] was already 1 (handled above)
			// or in_m was 0 (handled at the very beginning of the block). No shifting needed.
		end
	end
endmodule
