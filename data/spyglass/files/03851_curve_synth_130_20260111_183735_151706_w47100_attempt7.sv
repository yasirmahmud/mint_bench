module curve_synth_130_20260111_183735_151706_w47100_attempt7 (
    output out_data_0,
    output out_data_1,
    output out_data_2,
    output out_data_3,
    output out_data_4,
    input in_a,
    input in_b,
    input control_en
);
    nmos g0 (out_data_0, in_a, control_en);
    nmos g1 (out_data_1, in_b, control_en);
    nmos g2 (out_data_2, in_a, in_b);
    nmos g3 (out_data_3, 1'b0, control_en);
    nmos g4 (out_data_4, in_b, 1'b1);
endmodule
