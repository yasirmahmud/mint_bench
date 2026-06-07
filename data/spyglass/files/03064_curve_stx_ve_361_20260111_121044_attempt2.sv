`default_nettype none

module curve_stx_ve_361_20260111_121044_attempt2 (
    input wire in_a,
    output wire out_b
);

    wire problematic_net; // Declared as a net (wire)

    // STX_VE_361: Procedural assignment statement cannot drive a net
    // This 'always' block is a procedural assignment context.
    // Assigning to 'problematic_net' (a wire) within this block triggers the violation.
    always @(*) begin
        problematic_net = in_a;
    end

    // Connect the output to ensure 'problematic_net' is used and 'out_b' is driven.
    assign out_b = problematic_net;

endmodule
