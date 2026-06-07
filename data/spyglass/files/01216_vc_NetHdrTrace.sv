module vc_NetHdrTrace
(
  input  logic     clk,
  input  logic     reset,
  input  logic     val,
  input  logic     rdy,
  input  net_hdr_t hdr
);

  // Extract fields

  logic [1:0]    dest;
  logic [1:0]    src;
  logic [7:0]    opaque;

  assign dest   = hdr.dest;
  assign src    = hdr.src;
  assign opaque = hdr.opaque;

  // Line tracing

  logic [`VC_TRACE_NBITS-1:0] str;

  `VC_TRACE_BEGIN
  begin

    $sformat( str, "%x>%x:%x", src, dest, opaque );

    // Trace with val/rdy signals

    vc_trace.append_val_rdy_str( trace_str, val, rdy, str );

  end
  `VC_TRACE_END

endmodule
