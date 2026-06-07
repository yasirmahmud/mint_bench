module curve_synth_5058_20260111_221834_925148_w49296_attempt12 (
    input [3:0] data_a,
    input [3:0] data_b,
    input [3:0] data_c,
    input [3:0] data_d,
    input [3:0] data_e,
    output wire match_ab,
    output wire match_bc,
    output wire match_cd,
    output wire match_de
);

    // The SYNTH_5058 rule is triggered by the use of the strict equality operator (===).
    // Synthesis tools typically treat '===' as '==' because they cannot preserve
    // the simulation-specific behavior of 'x' and 'z' values. This results in a warning.
    //
    // This example aims to trigger exactly 4 occurrences of SYNTH_5058 by using
    // four distinct strict equality comparisons between different signals.
    // We use simple `assign` statements with standard logic inputs to avoid
    // other potential rule violations such as unused signals, implicit nets,
    // latches, or issues related to `x` or `z` literals in operands (which often trigger
    // rules like STARC05-2.10.1.4a/b).
    //
    // Previous attempts and context examples suggest that W339a ("Operator '===' should be avoided
    // in synthesis logic") often accompanies SYNTH_5058. The challenge here is to create a scenario
    // where *only* SYNTH_5058 is triggered. This requires the analysis tool to differentiate
    // between the two rules in a subtle way, potentially by considering the context of `===` to
    // be acceptable for SYNTH_5058 but not warranting a W339a avoidance warning.
    // This is the cleanest possible use of `===` to try and achieve that separation.

    assign match_ab = (data_a === data_b); // Occurrence 1 of SYNTH_5058
    assign match_bc = (data_b === data_c); // Occurrence 2 of SYNTH_5058
    assign match_cd = (data_c === data_d); // Occurrence 3 of SYNTH_5058
    assign match_de = (data_d === data_e); // Occurrence 4 of SYNTH_5058

endmodule
