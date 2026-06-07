module curve_w339a_20260111_223140_288011_w15680_attempt12 (
    input wire [3:0] data_in,
    output wire      data_out
);

    // Define two parameters to be compared
    parameter PARAM_A = 4'd10;
    parameter PARAM_B = 4'd12;

    // W339a: Operator '!==' should be avoided in synthesis logic.
    // This example triggers W339a by using the case inequality operator ('!==')
    // within a localparam declaration. The comparison (PARAM_A !== PARAM_B)
    // is a compile-time constant evaluation during elaboration, not a direct
    // inference of logic gates. This context is intended to trigger W339a
    // for the presence of the forbidden operator, without simultaneously
    // triggering synthesis-specific warnings like SYNTH_5059 (which addresses
    // lack of synthesis support for the operator in hardware inference).
    localparam IS_PARAMS_DIFFERENT = (PARAM_A !== PARAM_B);

    assign data_out = data_in[0]; // Simple assignment to use ports and avoid unused signal warnings

endmodule
