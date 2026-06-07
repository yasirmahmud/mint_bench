module curve_wrn_27_20260111_180650_632719_w7792_attempt10 (
    input [1:0] in_val,      // A small input vector (width 2: bits 0 and 1)
    output      out_a,       // Output for first WRN_27 violation
    output      out_b,       // Output for second WRN_27 violation
    output      out_c        // Output to ensure in_val's valid bits are used
);

wire [1:0] internal_data; // Declared width is [1:0]

// Assign input to an internal wire. This ensures 'in_val' is used.
assign internal_data = in_val;

// Use the bits within the declared range to prevent W528 (variable set but not read warning).
// The result is assigned to an output to ensure the logic is not optimized away.
assign out_c = internal_data[0] ^ internal_data[1]; // Uses both valid bits [0] and [1]

// WRN_27 violation 1: Bit-select 2 is out-of-range for a [1:0] vector.
// The result is assigned to an output to ensure the logic is not optimized away.
assign out_a = internal_data[2];

// WRN_27 violation 2: Bit-select 3 is out-of-range for a [1:0] vector.
// The result is assigned to an output to ensure the logic is not optimized away.
assign out_b = internal_data[3];

endmodule
