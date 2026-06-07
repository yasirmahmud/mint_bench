`default_nettype none

module curve_stx_ve_361_20260111_121044_attempt6 (
    input wire input_a,
    input wire input_b,
    output wire output_c
);

    // Declare 'problematic_net' as a net type (wire).
    wire problematic_net;

    // STX_VE_361: Procedural assignment statement cannot drive a net
    // This 'always @(*)' block is a procedural context.
    // Attempting to assign a value to 'problematic_net' (a wire) within this block
    // is a procedural assignment to a net, which triggers the STX_VE_361 violation.
    always @(*) begin
        if (input_a) begin
            problematic_net = input_b; // This line causes the STX_VE_361 violation.
        end else begin
            problematic_net = 1'b0;
        end
    end

    // The output uses 'problematic_net' to ensure it is not optimized away.
    assign output_c = problematic_net;

endmodule
