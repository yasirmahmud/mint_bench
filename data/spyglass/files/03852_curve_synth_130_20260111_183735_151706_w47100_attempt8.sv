module curve_synth_130_20260111_183735_151706_w47100_attempt8 (
    output out_q0,
    output out_q1,
    output out_q2,
    output out_q3,
    output out_q4,
    input in_data,
    input in_control,
    input in_enable
);

    // Each nmos instance will trigger a SYNTH_130 violation
    nmos g0 (out_q0, in_data, in_control);
    nmos g1 (out_q1, in_enable, 1'b1);
    nmos g2 (out_q2, 1'b0, in_control);
    nmos g3 (out_q3, in_data, 1'b0);
    nmos g4 (out_q4, in_enable, 1'b1);

endmodule
