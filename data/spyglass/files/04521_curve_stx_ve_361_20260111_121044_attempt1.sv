`default_nettype none

module curve_stx_ve_361_20260111_121044_attempt1 (
    input in_a,
    output out_b
);

    wire problematic_net;

    // STX_VE_361: Procedural assignment statement cannot drive a net
    always @(*) begin
        problematic_net = in_a; // Violation occurs here
    end

    // Connect the output to ensure 'problematic_net' is used and 'out_b' is driven
    assign out_b = problematic_net;

endmodule
