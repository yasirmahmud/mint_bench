module curve_w339a_20260111_223140_288011_w15680_attempt11 (
    input wire [2:0]  data_a,
    input wire [2:0]  data_b,
    input wire [2:0]  value_if_different,
    output wire [2:0] result_out
);
    // W339a: Operator '!==' should be avoided in synthesis logic.
    // This example uses the case inequality operator ('!==') within a synthesizable
    // conditional assignment statement. This construct is distinct from previous attempts
    // that used direct assignments or comparisons involving only constants.
    assign result_out = (data_a !== data_b) ? value_if_different : data_a;

endmodule
