module vc_Crossbar4
#(
  parameter p_nbits = 32
)
(
  input  wire [p_nbits-1:0]   in0,
  input  wire [p_nbits-1:0]   in1,
  input  wire [p_nbits-1:0]   in2,
  input  wire [p_nbits-1:0]   in3,

  input  wire [1:0]           sel0,
  input  wire [1:0]           sel1,
  input  wire [1:0]           sel2,
  input  wire [1:0]           sel3,

  output wire [p_nbits-1:0]   out0,
  output wire [p_nbits-1:0]   out1,
  output wire [p_nbits-1:0]   out2,
  output wire [p_nbits-1:0]   out3
);

  vc_Mux4#(p_nbits) out0_mux
  (
    .in0 (in0),
    .in1 (in1),
    .in2 (in2),
    .in3 (in3),
    .sel (sel0),
    .out (out0)
  );

  vc_Mux4#(p_nbits) out1_mux
  (
    .in0 (in0),
    .in1 (in1),
    .in2 (in2),
    .in3 (in3),
    .sel (sel1),
    .out (out1)
  );

  vc_Mux4#(p_nbits) out2_mux
  (
    .in0 (in0),
    .in1 (in1),
    .in2 (in2),
    .in3 (in3),
    .sel (sel2),
    .out (out2)
  );

  vc_Mux4#(p_nbits) out3_mux
  (
    .in0 (in0),
    .in1 (in1),
    .in2 (in2),
    .in3 (in3),
    .sel (sel3),
    .out (out3)
  );

endmodule
