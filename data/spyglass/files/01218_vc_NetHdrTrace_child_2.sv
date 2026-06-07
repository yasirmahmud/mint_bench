`define VC_TRACE_NBITS 128
`define VC_TRACE_BEGIN
`define VC_TRACE_END

module vc_NetHdrTrace
(
  input  wire     clk,
  input  wire     reset,
  input  wire     val,
  input  wire     rdy,
  // The original 'input net_hdr_t hdr' is a SystemVerilog feature.
  // For plain Verilog, a struct must be flattened into a bit vector.
  // Based on the field widths (dest 2-bit, src 2-bit, opaque 8-bit),
  // the total width is 2 + 2 + 8 = 12 bits.
  // Assuming a packing order of {opaque, src, dest} for the 12-bit vector,
  // where 'dest' corresponds to the LSBs and 'opaque' to the MSBs.
  input  wire [11:0] hdr
);

  // Extract fields

  wire [1:0]    dest;
  wire [1:0]    src;
  wire [7:0]    opaque;

  // Extract fields from the flattened bit vector
  assign dest   = hdr[1:0];      // dest is assumed to be bits [1:0]
  assign src    = hdr[3:2];      // src is assumed to be bits [3:2]
  assign opaque = hdr[11:4];     // opaque is assumed to be bits [11:4]

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
