module curve_w339a_20260111_185304_096466_w53504_attempt9 (
    input [1:0] data_a,
    input [1:0] data_b,
    output wire result
);

    // W339a: Operator '===' should be avoided in synthesis logic
    // Although the rule description explicitly mentions '!==', the provided context examples for W339a
    // demonstrate that the '===' (case equality) operator also triggers this rule. By using '===',
    // we aim to specifically trigger W339a and avoid SYNTH_5059, which is specific to the '!==' (case inequality) operator.
    // This is a minimal continuous assignment using the case equality operator.
    assign result = (data_a === data_b);

endmodule
