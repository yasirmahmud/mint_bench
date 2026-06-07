module imul_IntMulScycleV2
(
  input wire        clk,
  input wire        reset,

  input wire        in_val,
  input wire [31:0] in0,
  input wire [31:0] in1,

  output reg        out_val,
  output reg [31:0] out
);

  // ... implement your multiplier with valid bit below ...

  //----------------------------------------------------------------------
  // Line Tracing
  //----------------------------------------------------------------------

  `ifndef SYNTHESIS

  reg [`VC_TRACE_NBITS-1:0] str;
  `VC_TRACE_BEGIN
  begin

    $sformat( str, "%x|%x", in0, in1 );
    vc_trace.append_val_str( trace_str, in_val, str );

    vc_trace.append_str( trace_str, "(" );

    $sformat( str, "%x", in0_reg );
    vc_trace.append_val_str( trace_str, in_val_reg, str );
    vc_trace.append_str( trace_str, " " );

    $sformat( str, "%x", in1_reg );
    vc_trace.append_val_str( trace_str, in_val_reg, str );

    vc_trace.append_str( trace_str, ")" );

    $sformat( str, "%x", out );
    vc_trace.append_val_str( trace_str, out_val, str );

  end
  `VC_TRACE_END

  `endif /* SYNTHESIS */

endmodule
