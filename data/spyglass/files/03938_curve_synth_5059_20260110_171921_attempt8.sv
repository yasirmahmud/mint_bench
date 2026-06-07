module curve_synth_5059_20260110_171921_attempt8 (
    input [3:0] data_in,
    input [3:0] compare_val,
    output reg flag_out
);

// Target rule: SYNTH_5059 - Case inequality (!==) encountered which is not supported by synthesis.
// This module specifically uses the ! Weinberg operator to trigger the rule.
always @* begin
    if (data_in !== compare_val) begin
        flag_out = 1'b1;
    end else begin
        flag_out = 1'b0;
    end
end

endmodule
