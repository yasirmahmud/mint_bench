module curve_wrn_27_20260111_180650_632719_w7792_attempt7 (
    input [7:0] i_data,
    output      o_msb_plus_1,
    output      o_msb_plus_2
);

// The original intent to use 'my_vec' for bit-selects 8 and 9 was erroneous
// as a [7:0] vector does not have these bits. To resolve the out-of-range
// bit-select violations (SYNTH_5255, WRN_27) and preserve functional behavior
// by defining what these non-existent bits should be, they are assigned to 0.
// Since 'my_vec' is no longer used for any valid read, it is removed along
// with its assignment to resolve the W528 warning (set but not read).

// Violation 1: Bit-select 8 is out-of-range for a [7:0] vector
// Assign 0 to the output for the non-existent bit.
assign o_msb_plus_1 = 1'b0;

// Violation 2: Bit-select 9 is out-of-range for a [7:0] vector
// Assign 0 to the output for the non-existent bit.
assign o_msb_plus_2 = 1'b0;

endmodule
