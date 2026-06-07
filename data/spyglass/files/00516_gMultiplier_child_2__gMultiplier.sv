module gMultiplier  (
	a,
	b,
	out
);

	input [15:0] a;
	input [15:0] b;
	output wire [15:0] out;

	// Module-level `reg`s. All `reg`s within an `always @(*)` block must be assigned
	// in all possible execution paths to avoid latch inference.
	reg a_sign;
	reg [7:0] a_exponent;
	reg [7:0] a_mantissa;
	reg b_sign;
	reg [7:0] b_exponent;
	reg [7:0] b_mantissa;
	reg o_sign;
	reg [7:0] o_exponent;
	reg [7:0] o_mantissa; // Corrected size from [8:0] to [7:0] to match `product[14:7]` (8 bits assigned, bit 8 would be unused).
	reg [15:0] product; // This `product` reg holds the final mantissa product after normalization.

	// Intermediate variables for calculations within the always block, declared at module level to comply with Verilog-2001.
	reg [7:0] current_o_exponent;
	reg [15:0] current_product_mantissa;

	// Inputs to the normalizer module. These `reg`s must be assigned unconditionally
	// within the `always @(*)` block to avoid latch inference.
	reg [7:0] i_e;
	reg [15:0] i_m;

	// Outputs from the normalizer are wires.
	wire [7:0] o_e;
	wire [15:0] o_m;

	// Instance of the normalizer module.
	multiplication_normaliser norm1(
		.in_e(i_e),
		.in_m(i_m),
		.out_e(o_e),
		.out_m(o_m)
	);

	// Output assignments for 'out' port.
	assign out[15] = o_sign;
	assign out[14:7] = o_exponent;
	assign out[6:0] = o_mantissa[6:0]; // Takes 7 bits from the 8-bit o_mantissa

	// Combinational logic for the floating-point multiplier
	always @(*) begin
		// Default assignments for all `reg`s to guarantee they are assigned in every path.
		// This resolves latch inference violations.
		a_sign = 1'b0;
		a_exponent = 8'b0;
		a_mantissa = 8'b0;
		b_sign = 1'b0;
		b_exponent = 8'b0;
		b_mantissa = 8'b0;
		o_sign = 1'b0;
		o_exponent = 8'b0;
		o_mantissa = 8'b0;
		product = 16'b0;
		i_e = 8'b0;  // Default assignment to prevent latch for i_e
		i_m = 16'b0; // Default assignment to prevent latch for i_m
		// Default assignments for the moved intermediate variables
		current_o_exponent = 8'b0;
		current_product_mantissa = 16'b0;

		// --- Unpack 'a' --- 
		a_sign = a[15];
		if (a[14:7] == 0) begin // Denormalized or zero 'a' case
			a_exponent = 8'b00000001; // Smallest normal exponent bias for denormalized numbers
			a_mantissa = {1'b0, a[6:0]}; // Explicit leading zero for denormalized mantissa
		end else begin // Normalized 'a' case
			a_exponent = a[14:7];
			a_mantissa = {1'b1, a[6:0]}; // Explicit leading one for normalized mantissa
		end

		// --- Unpack 'b' --- 
		b_sign = b[15];
		if (b[14:7] == 0) begin // Denormalized or zero 'b' case
			b_exponent = 8'b00000001; // Smallest normal exponent bias
			b_mantissa = {1'b0, b[6:0]}; // Explicit leading zero for denormalized mantissa
		end else begin // Normalized 'b' case
			b_exponent = b[14:7];
			b_mantissa = {1'b1, b[6:0]}; // Explicit leading one for normalized mantissa
		end

		// --- Calculate product sign and initial exponent/mantissa --- 
		o_sign = a_sign ^ b_sign;
		current_o_exponent = (a_exponent + b_exponent) - 127; // Exponent bias adjustment
		current_product_mantissa = a_mantissa * b_mantissa; // Mantissa multiplication

		// --- First normalization step: Adjust for potential extra bit from mantissa product --- 
		// (e.g., 1.x * 1.y can result in 1x.z, needing a right shift and exponent increment)
		if (current_product_mantissa[15] == 1) begin
			current_o_exponent = current_o_exponent + 1;
			current_product_mantissa = current_product_mantissa >> 1;
		end

		// --- Set inputs for the `multiplication_normaliser` module. --- 
		// These assignments are unconditional, resolving `InferLatch` for `i_e` and `i_m`.
		i_e = current_o_exponent;
		i_m = current_product_mantissa;

		// --- Second normalization step: Adjust for leading zeros using the normalizer module --- 
		// If `current_product_mantissa[14]` is 0 and `current_o_exponent` is not 0,
		// it indicates a need for left shifting to normalize the mantissa.
		if ((current_product_mantissa[14] != 1) && (current_o_exponent != 0)) begin
			// If normalization is required, use the output from the `multiplication_normaliser`.
			// `o_e` and `o_m` are always valid outputs from the concurrently running `norm1` instance.
			o_exponent = o_e;
			product = o_m;
		end else begin
			// Otherwise, use the mantissa and exponent as they are (after the first adjustment).
			// This 'else' branch ensures `o_exponent` and `product` are always assigned, preventing latches.
			o_exponent = current_o_exponent;
			product = current_product_mantissa;
		end

		// --- Final mantissa assignment for output --- 
		o_mantissa = product[14:7]; // Assigns the 8-bit normalized mantissa part
	end
endmodule
