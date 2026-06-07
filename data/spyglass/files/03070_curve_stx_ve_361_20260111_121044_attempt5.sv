`default_nettype none

module curve_stx_ve_361_20260111_121044_attempt5 (
    input wire clk_neg,
    input wire [3:0] input_val,
    output wire [3:0] output_signal
);

    // Declare 'problematic_wire' as a net type (wire).
    wire [3:0] problematic_wire;

    // STX_VE_361: Procedural assignment statement cannot drive a net
    // This 'always @(negedge clk_neg)' block is a procedural context.
    // Attempting to assign a value to 'problematic_wire' (a wire) within this block
    // is a procedural assignment to a net, which triggers the STX_VE_361 violation.
    always @(negedge clk_neg) begin
        problematic_wire = input_val; // This line causes the STX_VE_361 violation.
    end

    // The output uses 'problematic_wire' to ensure it is not optimized away.
    assign output_signal = problematic_wire;

endmodule
