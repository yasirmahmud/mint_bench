module curve_synth_5034_20260111_134108_attempt6 (
    input [3:0] data_in,
    output reg result_out
);

always @(*) begin
    result_out = 1'b0; // Default assignment to avoid latches

    // SYNTH_5034: "Comparison with don't care or tristate will be always false"
    // This rule is triggered when a 'case' statement (not 'casez') uses a literal
    // with 'x' or 'z' bits for a comparison item, and the selector is a synthesizable
    // signal (like an input port). In synthesized hardware, input signals will only
    // ever be '0' or '1'. Therefore, the corresponding bits in the selector can
    // never match 'x' (unknown) or 'z' (high-impedance) literals from the case item.
    // This makes the comparison for those bits always false, rendering the entire
    // case item effectively unreachable from a synthesis perspective.
    casez (data_in) // Changed 'case' to 'casez' to correctly interpret 'x' as a don't care.
        4'b0001: result_out = 1'b1;
        4'b001x: result_out = 1'b1;
        4'b0100: result_out = 1'b0;
        default: result_out = 1'b0;
    endcase
end

endmodule
