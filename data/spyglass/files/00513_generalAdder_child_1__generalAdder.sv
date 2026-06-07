module generalAdder  (
	a,
	b,
	out
);

	input [31:0] a;
	input [31:0] b;
	output wire [31:0] out;

	reg a_sign;
	reg b_sign;
	reg [7:0] a_exponent;
	reg [7:0] b_exponent;
	reg [23:0] a_mantissa;
	reg [23:0] b_mantissa;

	// Intermediate results before normalization/overflow handling
	reg o_sign_intermediate;
	reg [7:0] o_exponent_intermediate;
	reg [24:0] o_mantissa_intermediate; // Needs 25 bits for addition/subtraction result

	// Results after initial overflow check but before full normalization
	reg o_sign_post_overflow;
	reg [7:0] o_exponent_post_overflow;
	reg [24:0] o_mantissa_post_overflow;

	// Inputs to the normalizer module
	reg [7:0] i_e;
	reg [24:0] i_m;

	// Outputs from the normalizer module (wires)
	wire [7:0] o_e_norm_out;
	wire [24:0] o_m_norm_out;

	// Final outputs assigned from the always block
	reg o_sign;
	reg [7:0] o_exponent;
	reg [24:0] o_mantissa; // Final mantissa, with [23] as implicit '1' (for normal numbers)

	reg [7:0] diff;
	reg [23:0] tmp_mantissa;

	// Instantiate the normalizer.
	addition_normaliser norm1(
		.in_e(i_e),
		.in_m(i_m),
		.out_e(o_e_norm_out),
		.out_m(o_m_norm_out)
	);

	assign out[31] = o_sign;
	assign out[30:23] = o_exponent;
	assign out[22:0] = o_mantissa[22:0]; // Truncate to 23 bits for output (fraction part)

	always @(*) begin
		// Default assignments for all 'reg' signals to prevent latch inference
		a_sign = 1'b0;
		b_sign = 1'b0;
		a_exponent = 8'b0;
		a_mantissa = 24'b0;
		b_exponent = 8'b0;
		b_mantissa = 24'b0;
		o_sign_intermediate = 1'b0;
		o_exponent_intermediate = 8'b0;
		o_mantissa_intermediate = 25'b0;
		o_sign_post_overflow = 1'b0;
		o_exponent_post_overflow = 8'b0;
		o_mantissa_post_overflow = 25'b0;
		i_e = 8'b0;
		i_m = 25'b0;
		o_sign = 1'b0;
		o_exponent = 8'b0;
		o_mantissa = 25'b0;
		diff = 8'b0;
		tmp_mantissa = 24'b0;

		// 1. Parse inputs and handle denormals (implicit 1 for normal numbers)
		a_sign = a[31];
		if (a[30:23] == 8'b0) begin // Denormalized 'a' or zero
			a_exponent = 8'b00000001; // Smallest normal exponent for internal calculation
			a_mantissa = {1'b0, a[22:0]}; // Leading 0 for denormal / zero mantissa
		end
		else begin // Normal 'a'
			a_exponent = a[30:23];
			a_mantissa = {1'b1, a[22:0]}; // Implicit leading 1
		end

		b_sign = b[31];
		if (b[30:23] == 8'b0) begin // Denormalized 'b' or zero
			b_exponent = 8'b00000001; // Smallest normal exponent for internal calculation
			b_mantissa = {1'b0, b[22:0]}; // Leading 0 for denormal / zero mantissa
		end
		else begin // Normal 'b'
			b_exponent = b[30:23];
			b_mantissa = {1'b1, b[22:0]}; // Implicit leading 1
		end

		// 2. Align exponents and perform mantissa arithmetic
		if (a_exponent == b_exponent) begin
			o_exponent_intermediate = a_exponent;
			if (a_sign == b_sign) begin
				o_mantissa_intermediate = a_mantissa + b_mantissa; // o_mantissa[24] will naturally be 1 on overflow
				o_sign_intermediate = a_sign;
			end
			else begin // Signs differ, perform subtraction
				if (a_mantissa >= b_mantissa) begin 
					o_mantissa_intermediate = a_mantissa - b_mantissa;
					o_sign_intermediate = a_sign;
				end
				else begin
					o_mantissa_intermediate = b_mantissa - a_mantissa;
					o_sign_intermediate = b_sign;
				end
			end
		end
		else if (a_exponent > b_exponent) begin
			o_exponent_intermediate = a_exponent;
			o_sign_intermediate = a_sign;
			diff = a_exponent - b_exponent;
			tmp_mantissa = b_mantissa >> diff;
			if (a_sign == b_sign)
				o_mantissa_intermediate = a_mantissa + tmp_mantissa;
			else
				o_mantissa_intermediate = a_mantissa - tmp_mantissa;
		end
		else begin // a_exponent < b_exponent
			o_exponent_intermediate = b_exponent;
			o_sign_intermediate = b_sign;
			diff = b_exponent - a_exponent;
			tmp_mantissa = a_mantissa >> diff;
			if (a_sign == b_sign)
				o_mantissa_intermediate = b_mantissa + tmp_mantissa;
			else
				o_mantissa_intermediate = b_mantissa - tmp_mantissa;
		end

		// 3. Handle immediate overflow (mantissa bit 24 is set from previous addition)
		o_sign_post_overflow = o_sign_intermediate;
		if (o_mantissa_intermediate[24] == 1) begin
			o_exponent_post_overflow = o_exponent_intermediate + 1;
			o_mantissa_post_overflow = o_mantissa_intermediate >> 1;
		end
		else begin
			o_exponent_post_overflow = o_exponent_intermediate;
			o_mantissa_post_overflow = o_mantissa_intermediate;
		end

		// 4. Determine final output based on normalization needs
		o_sign = o_sign_post_overflow; // Final sign is determined earlier

		// Inputs to normalizer module always get current post-overflow values
		// This ensures i_e, i_m are always assigned, preventing latches.
		i_e = o_exponent_post_overflow;
		i_m = o_mantissa_post_overflow;

		if ((o_mantissa_post_overflow[23] != 1) && (o_exponent_post_overflow != 8'b0)) begin
			// Needs further normalization by the module if mantissa[23] is not set and exponent is not zero
			o_exponent = o_e_norm_out; // Assign from normalizer output wire
			o_mantissa = o_m_norm_out; // Assign from normalizer output wire
		end
		else begin
			// Already normalized (mantissa[23] is 1), or is zero/denormal result (exponent is 0).
			// No further normalization needed by the module.
			o_exponent = o_exponent_post_overflow;
			o_mantissa = o_mantissa_post_overflow;
		end
	end
endmodule
