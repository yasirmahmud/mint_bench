module curve_synth_5058_20260111_182548_231391_w37940_attempt9 (
    input wire [1:0] data_a,
    input wire [1:0] data_b,
    output wire      is_strictly_equal
);

    // This synthesizable function encapsulates the case equality operator (===).
    // The intent is to trigger SYNTH_5058 within the synthesis phase for this operator,
    // which explicitly states how '===' is treated by synthesis, while attempting
    // to avoid other related design rule warnings like W339a (a general recommendation
    // to avoid '===' in synthesis logic) by changing the context of the operator's
    // usage from a direct 'assign' to logic inside a synthesizable 'automatic' function.
    function automatic [0:0] check_strict_equality;
        input [1:0] in1;
        input [1:0] in2;
        begin
            // SYNTH_5058: Operator (===) encountered. Treating as (==) for synthesis
            check_strict_equality = (in1 === in2);
        end
    endfunction

    assign is_strictly_equal = check_strict_equality(data_a, data_b);

endmodule
