`define VC_TRACE_NBITS 128
`define VC_TRACE_BEGIN
`define VC_TRACE_END

module vc_NetHdrTrace
(
  input  wire     clk,
  input  wire     reset,
  input  wire     val,
  input  wire     rdy,
  input  net_hdr_t hdr
);

  // Extract fields

  wire [1:0]    dest;
  wire [1:0]    src;
  wire [7:0]    opaque;

  assign dest   = hdr.dest;
  assign src    = hdr.src;
  assign opaque = hdr.opaque;

  // Line tracing

  wire [`VC_TRACE_NBITS-1:0] str;

  `VC_TRACE_BEGIN
  begin

    $sformat( str, "%x>%x:%x", src, dest, opaque );

    // Trace with val/rdy signals

    vc_trace.append_val_rdy_str( str, val, rdy, str );

  end
  `VC_TRACE_END

endmodule
