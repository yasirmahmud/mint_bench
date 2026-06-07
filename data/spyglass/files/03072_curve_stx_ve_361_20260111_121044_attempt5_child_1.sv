`default_nettype none

module curve_stx_ve_361_20260111_121044_attempt5 (
    input wire clk_neg,
    input wire [3:0] input_val,
    output wire [3:0] output_signal
);

    // Declare 'problematic_wire' as a reg type since it's assigned procedurally.
    reg [3:0] problematic_wire; // Changed from 'wire' to 'reg' to resolve STX_VE_361

    // This 'always @(negedge clk_neg)' block is a procedural context.
    // Assigning to 'problematic_wire' (now a reg) within this block
    // is a valid procedural assignment.
    always @(negedge clk_neg) begin
        problematic_wire = input_val; // This line is now valid.
    end

    // The output uses 'problematic_wire' to ensure it is not optimized away.
    assign output_signal = problematic_wire;

endmodule
