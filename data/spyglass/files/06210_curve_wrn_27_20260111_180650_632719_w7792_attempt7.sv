module curve_wrn_27_20260111_180650_632719_w7792_attempt7 (
    input [7:0] i_data,
    output      o_msb_plus_1,
    output      o_msb_plus_2
);

wire [7:0] my_vec;

// Assign input to internal wire to ensure input is used
assign my_vec = i_data;

// Violation 1: Bit-select 8 is out-of-range for a [7:0] vector
assign o_msb_plus_1 = my_vec[8];

// Violation 2: Bit-select 9 is out-of-range for a [7:0] vector
assign o_msb_plus_2 = my_vec[9];

endmodule
