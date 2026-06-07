module curve_synth_5034_20260111_134108_attempt4 (
    input [7:0] data_in,
    output reg [2:0] priority_out,
    output reg valid_out
);

always @(*) begin
    priority_out = 3'b000;
    valid_out = 1'b0;

    // SYNTH_5034: "Comparison with don't care or tristate will be always false"
    // This rule typically fires when a synthesizable input (which can only assume '0' or '1' values)
    // is compared against a pattern that includes 'z' (or 'x') bits in a 'casez' statement.
    // While 'casez' is designed to treat 'z' (and '?') as don't-cares in the case item pattern,
    // if the corresponding bits in the selector signal ('data_in' here) will *never* physically
    // assume a 'z' state in synthesized hardware, then the comparison for those 'z' bits in the pattern
    // will always evaluate to false. This renders the specific case item branch unreachable from a synthesis
    // perspective, thus triggering SYNTH_5034.
    // This example specifically uses 'z' in a 'casez' item (8'b001zzzzz) to target SYNTH_5034.
    // This approach is intended to be distinct from using 'x' in a standard 'case' or 'casez' statement,
    // which often triggers additional rules like W337 ('Illegal value as case item' or 'Comparison to X/Z always false')
    // due to 'x' being treated as a literal 'x' by some tools or being considered inherently 'illegal' for synthesizable inputs.
    // By using 'z' in 'casez', we aim to isolate SYNTH_5034 as a warning about an effectively unreachable don't-care comparison
    // in a synthesizable context, without triggering other rules related to strictly 'illegal' values.
    casez (data_in)
        8'b10000000: begin priority_out = 3'b111; valid_out = 1'b1; end
        8'b01000000: begin priority_out = 3'b110; valid_out = 1'b1; end
        8'b001zzzzz: begin priority_out = 3'b101; valid_out = 1'b1; end // Target line for SYNTH_5034
        8'b00010000: begin priority_out = 3'b100; valid_out = 1'b1; end
        8'b00001000: begin priority_out = 3'b011; valid_out = 1'b1; end
        8'b00000100: begin priority_out = 3'b010; valid_out = 1'b1; end
        8'b00000010: begin priority_out = 3'b001; valid_out = 1'b1; end
        8'b00000001: begin priority_out = 3'b000; valid_out = 1'b1; end
        default: begin priority_out = 3'b000; valid_out = 1'b0; end
    endcasez
end

endmodule
