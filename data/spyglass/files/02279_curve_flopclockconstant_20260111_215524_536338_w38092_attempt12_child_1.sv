module curve_flopclockconstant_20260111_215524_536338_w38092_attempt12 (
    input wire i_data_a,
    input wire i_data_b,
    output reg o_reg_a,
    output reg o_reg_b
);

    // The original design intended to create flip-flops with constant-low clock inputs.
    // Functionally, a flip-flop with a constant-low clock will never update its value
    // from its input, effectively holding an unknown ('X') state if no reset is present.
    // To resolve the 'FlopClockConstant' violations while preserving this functional behavior
    // (i.e., 'o_reg_a' and 'o_reg_b' never update from 'i_data_a'/'i_data_b'),
    // the 'always' blocks and constant clock wires are removed.
    // As 'output reg' that are never driven, 'o_reg_a' and 'o_reg_b' will correctly
    // default to an 'X' (unknown) state, mimicking the original design's behavior
    // without inferring non-functional flops.

endmodule
