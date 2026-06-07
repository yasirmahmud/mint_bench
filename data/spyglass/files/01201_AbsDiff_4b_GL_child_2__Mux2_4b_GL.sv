module Mux2_4b_GL
(
  input  wire [3:0] in0,
  input  wire [3:0] in1,
  input  wire       sel,
  output wire [3:0] out
);
  assign out = sel ? in1 : in0;
endmodule
