module curve_synth_5059_20260111_214911_310203_w15680_attempt11 (
    input [3:0] data_in,
    output wire result_out
);

wire [3:0] compare_val = 4'b10z1; // Constant with 'z' literal

// Trigger SYNTH_5059: Case inequality (!==) in a conditional (ternary) operator
assign result_out = (data_in !== compare_val) ? 1'b1 : 1'b0;

endmodule
