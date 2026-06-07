module curve_synth_130_20260111_183735_151706_w47100_attempt6 (
    output out1,
    output out2,
    output out3,
    output out4,
    output out5,
    input in1,
    input in2,
    input in3,
    input in4,
    input in5,
    input ctrl1,
    input ctrl2,
    input ctrl3,
    input ctrl4,
    input ctrl5
);
    nmos n1 (out1, in1, ctrl1);
    nmos n2 (out2, in2, ctrl2);
    nmos n3 (out3, in3, ctrl3);
    nmos n4 (out4, in4, ctrl4);
    nmos n5 (out5, in5, ctrl5);
endmodule
