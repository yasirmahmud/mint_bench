module curve_synth_5058_20260111_182548_231391_w37940_attempt8 (
    input wire [3:0] in1,
    input wire [3:0] in2,
    output wire      are_strictly_equal
);

    // SYNTH_5058: Operator (===) encountered. Treating as (==) for synthesis
    // This example uses the case equality operator '===' to compare two
    // 4-bit input signals. The intent is to trigger SYNTH_5058 by using
    // '===' in synthesizable logic. To isolate this specific violation,
    // the comparison avoids explicit 'x' or 'z' literals as operands,
    // which helps prevent related STARC and W339a rules.
    assign are_strictly_equal = (in1 === in2);

endmodule
