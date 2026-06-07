module curve_synth_5034_20260111_230756_599726_w49296_attempt12 (
    input wire [2:0] in_data,
    output reg out_flag
);

always @(*) begin
    out_flag = 1'b0; // Default assignment to avoid latches

    // SYNTH_5034: Comparison with don't care ('x') will always be false in synthesis.
    // A typical synthesis tool assumes that input signals or internal register values
    // will resolve to either 0 or 1. Therefore, when a bit of 'in_data' (e.g., in_data[1])
    // is compared to a don't-care 'x' bit from the literal constant (3'b1x0),
    // the condition 'in_data[1] == 1'bx' will always evaluate to false.
    // This makes the entire 'if' branch effectively unreachable in synthesis, triggering the violation.
    if (in_data == 3'b1x0) begin
        out_flag = 1'b1;
    end
end

endmodule
