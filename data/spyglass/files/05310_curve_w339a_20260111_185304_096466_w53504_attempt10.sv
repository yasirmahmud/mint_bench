module curve_w339a_20260111_185304_096466_w53504_attempt10 (
    output wire result
);

    // W339a: Operator '!==' should be avoided in synthesis logic
    // This example uses the '!==' operator to compare two different unknown/high-impedance values.
    // Since the expression (1'bx !== 1'bz) evaluates to a constant (1'b1), 
    // it is hoped that a sophisticated linter/synthesizer might evaluate this 
    // during elaboration/constant propagation, thus avoiding 'SYNTH_5059' 
    // (which is about treating '!==' as '!=') while still flagging W339a 
    // for the presence of the forbidden operator in the RTL source.
    assign result = (1'bx !== 1'bz);

endmodule
