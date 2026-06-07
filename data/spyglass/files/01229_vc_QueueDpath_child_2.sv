`define VC_QUEUE_NORMAL 1'b0
`define VC_QUEUE_BYPASS 1'b1

module vc_QueueDpath1
#(
  parameter p_type      = `VC_QUEUE_NORMAL,
  parameter p_msg_nbits = 1
)(
  input  wire                   clk,
  input  wire                   reset,
  input  wire                   write_en,
  input  wire                   bypass_mux_sel,
  input  wire [p_msg_nbits-1:0] enq_msg,
  output wire [p_msg_nbits-1:0] deq_msg
);

  // Queue storage

  wire [p_msg_nbits-1:0] qstore;

  vc_EnReg#(p_msg_nbits) qstore_reg
  (
    .clk   (clk),
    .reset (reset),
    .en    (write_en),
    .d     (enq_msg),
    .q     (qstore)
  );

  // Bypass muxing

  generate
  if ( |(p_type & `VC_QUEUE_BYPASS ) )

    vc_Mux2#(p_msg_nbits) bypass_mux
    (
      .in0 (qstore),
      .in1 (enq_msg),
      .sel (bypass_mux_sel),
      .out (deq_msg)
    );

  else
    assign deq_msg = qstore;
  endgenerate

endmodule
