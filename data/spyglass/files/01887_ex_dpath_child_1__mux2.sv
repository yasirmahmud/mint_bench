module mux2(out, in1, in0, sel);
  output        out;
  input         in1, in0;
  input         sel;
  assign out = sel ? in1 : in0;
endmodule
