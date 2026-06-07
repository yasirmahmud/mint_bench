module curve_synth_5059_20260112_000730_661766_w25608_attempt16 (
    input       data_in,
    output      result_out
);

    parameter REFERENCE_BIT = 1'b1;

    // Trigger SYNTH_5059: Case inequality (!==) which is not supported by synthesis.
    // This example uses a continuous assignment comparing a single input bit with a single bit parameter.
    assign result_out = (data_in !== REFERENCE_BIT);

endmodule
