module curve_wrn_27_20260111_180650_632719_w7792_attempt9 (
    input [3:0] in_data,
    output      out_bit_a,
    output      out_bit_b
);

wire [3:0] internal_vector;

// Assign input to an internal wire. This ensures 'in_data' is used 
// and provides the vector for out-of-range access.
assign internal_vector = in_data;

// WRN_27 violation 1: Bit-select 4 is out-of-range for a [3:0] vector.
// The result is assigned to an output to ensure the logic is not optimized away.
assign out_bit_a = internal_vector[4];

// WRN_27 violation 2: Bit-select 5 is out-of-range for a [3:0] vector.
// The result is assigned to an output to ensure the logic is not optimized away.
assign out_bit_b = internal_vector[5];

endmodule
