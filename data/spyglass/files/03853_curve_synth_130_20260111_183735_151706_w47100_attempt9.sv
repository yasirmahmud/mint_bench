module curve_synth_130_20260111_183735_151706_w47100_attempt9 (
    output out_p0,
    output out_p1,
    output out_p2,
    output out_p3,
    output out_p4,
    input  sig_a,
    input  sig_b,
    input  ctrl_c
);

    // Each nmos instance will trigger a SYNTH_130 violation (nmos gate types are not supported)
    nmos p0 (out_p0, sig_a, ctrl_c);
    nmos p1 (out_p1, sig_b, 1'b1);
    nmos p2 (out_p2, 1'b1, ctrl_c);
    nmos p3 (out_p3, sig_a, 1'b0);
    nmos p4 (out_p4, 1'b0, sig_b);

endmodule
