module curve_synth_5058_20260111_182548_231391_w37940_attempt7 (
    input wire [7:0] data_in,
    output wire       is_all_x
);

    // SYNTH_5058: Operator (===) encountered. Treating as (==) for synthesis
    // This assignment uses the case equality operator '===' to check if
    // an 8-bit input bus is strictly equal to an 'X' (unknown) value across all bits.
    // Synthesis tools will typically convert '===' to '==' for hardware
    // implementation, which is the warning SYNTH_5058.
    // This scenario specifically involves comparing against an unsized 'X' value,
    // which is distinct from comparing two regular logic signals or a signal against 0/1 literals.
    assign is_all_x = (data_in === 'bx);

endmodule
