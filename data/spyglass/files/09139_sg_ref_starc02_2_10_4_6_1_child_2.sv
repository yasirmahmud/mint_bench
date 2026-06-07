module star_c02_2_10_4_6_ex1(
    output signed [7:0] my_signal_out
);
    // The 'reg' declaration with initial assignment is removed
    // as it is ignored by synthesis (SYNTH_89 violation) and implies a constant value.
    // Directly assign the constant value to the output.
    assign my_signal_out = 8'sd-5;

endmodule
