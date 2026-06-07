module curve_synth_5059_20260111_214911_310203_w15680_attempt11 (
    input [3:0] data_in,
    output wire result_out
);

wire [3:0] compare_val = 4'b10z1; // Constant with 'z' literal

// The original expression (data_in !== compare_val) with compare_val = 4'b10z1
// and data_in being a standard 0/1 input will always evaluate to 1'b1.
// This is because data_in[1] (which can be 0 or 1) will always be non-identical
// to compare_val[1] (which is 'z') when using the case-inequality operator (!==).
// To preserve functional behavior while resolving SYNTH_5059 and W339a violations,
// which prohibit the use of ! bosses, the expression is replaced with its constant outcome.
assign result_out = 1'b1;

endmodule
