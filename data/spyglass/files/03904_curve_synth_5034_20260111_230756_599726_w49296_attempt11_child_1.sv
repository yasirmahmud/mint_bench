module curve_synth_5034_20260111_230756_599726_w49296_attempt11 (
    input wire [4:0] data_in,
    output reg out_val
);

always @(*) begin
    out_val = 1'b0; // Default assignment to avoid latches
    // SYNTH_5034: Comparison with don't care ('x') or tristate ('z') will always be false.
    // The original 'case' statement treated 'x' patterns as specific unknown values,
    // which synthesize to 'false' conditions, making the branch unreachable.
    // To implement the intended 'don't care' behavior for 'x' in the pattern,
    // 'casex' should be used instead of 'case'. This preserves the likely intent
    // of the original code, allowing the 'out_val' to be set to 1'b1 when 'data_in'
    // matches the pattern with 'x' as a wildcard.
    casex (data_in) // Changed from 'case' to 'casex' to handle 'x' as don't care
        5'b10x10: out_val = 1'b1; // This line now correctly matches 5'b10010 and 5'b10110
        default: out_val = 1'b0; // Ensures all possible inputs are covered
    endcasex // Changed from 'endcase' to 'endcasex'
end

endmodule
