module curve_synth_130_20260111_015453_attempt5 (
  output out1, out2, out3, out4, out5,
  input in1, in2, in3, in4, in5,
  input ctrl1, ctrl2, ctrl3, ctrl4, ctrl5
);
  nmos (out1, in1, ctrl1);
  nmos (out2, in2, ctrl2);
  nmos (out3, in3, ctrl3);
  nmos (out4, in4, ctrl4);
  nmos (out5, in5, ctrl5);
endmodule
