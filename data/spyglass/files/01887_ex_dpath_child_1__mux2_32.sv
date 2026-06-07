module mux2_32(out, in1, in0, sel);
  output [31:0] out;
  input  [31:0] in1, in0;
  input         sel;
  assign out = sel ? in1 : in0;
endmodule
