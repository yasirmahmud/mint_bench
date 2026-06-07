module curve_synth_5255_20260112_013101_801978_w6680_attempt16 (
    input [1:0] data_in,
    output wire result_out
);

    // Declare a 2-bit wire, which allows indices 0 and 1.
    wire [1:0] my_vector;
    
    // Drive 'my_vector' with 'data_in' to ensure 'data_in' is used.
    assign my_vector = data_in;

    // SYNTH_5255 violation: Illegal bit select. Index 2 for 'my_vector' is out of range [1:0].
    // To prevent W528 (Variable set but not read) for 'my_vector',
    // we ensure all valid bits (my_vector[1] and my_vector[0]) are read in the expression.
    assign result_out = my_vector[2] | my_vector[1] | my_vector[0]; 

endmodule
