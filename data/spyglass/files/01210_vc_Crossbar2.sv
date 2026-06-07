module vc_Crossbar2
#(
  parameter p_nbits = 32
)
(
  input  logic [p_nbits-1:0]   in0,
  input  logic [p_nbits-1:0]   in1,

  input  logic                 sel0,
  input  logic                 sel1,

  output logic [p_nbits-1:0]   out0,
  output logic [p_nbits-1:0]   out1
);

  vc_Mux2#(p_nbits) out0_mux
  (
    .in0 (in0),
    .in1 (in1),
    .sel (sel0),
    .out (out0)
  );

  vc_Mux2#(p_nbits) out1_mux
  (
    .in0 (in0),
    .in1 (in1),
    .sel (sel1),
    .out (out1)
  );

endmodule
