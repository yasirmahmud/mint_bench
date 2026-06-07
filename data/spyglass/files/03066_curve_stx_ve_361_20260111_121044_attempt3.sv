`default_nettype none

module curve_stx_ve_361_20260111_121044_attempt3 (
    input wire clk,
    input wire data_in,
    output wire out_data
);

    // 'problematic_wire' is declared as a net type (wire).
    wire problematic_wire;

    // STX_VE_361: Procedural assignment statement cannot drive a net
    // Attempting to assign to 'problematic_wire' (a wire) within this 'always' block,
    // which is a procedural context, will trigger the violation on the line below.
    always @(posedge clk) begin
        problematic_wire = data_in; // This is a procedural assignment to a net.
    end

    // The output uses the problematic wire to ensure it is not optimized away.
    assign out_data = problematic_wire;

endmodule
