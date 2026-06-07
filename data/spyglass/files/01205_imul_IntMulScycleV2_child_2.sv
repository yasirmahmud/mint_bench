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

  // Declare internal registers used for tracing.
  // These registers will store the inputs that were used to compute the *current* output.
  reg        in_val_reg;
  reg [31:0] in0_reg;
  reg [31:0] in1_reg;

  // Combinatorial multiplication of current inputs
  // A 32x32 multiplication results in a 64-bit product. We assume unsigned multiplication
  // as implied by the [31:0] ports for integers.
  wire [63:0] product_current_cycle;
  assign product_current_cycle = $unsigned(in0) * $unsigned(in1);

  // Registered output logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset output registers
      out_val    <= 1'b0;
      out        <= 32'b0;
      // Reset internal trace registers
      in_val_reg <= 1'b0;
      in0_reg    <= 32'b0;
      in1_reg    <= 32'b0;
    end else begin
      // Register the computed output and its validity for the next cycle
      out_val    <= in_val;
      out        <= product_current_cycle[31:0]; // Truncate to 32 bits for the output port

      // Register the inputs for tracing purposes.
      // These store the inputs that *just* passed through the combinatorial multiplier
      // and are now present at the output registers (out, out_val).
      in_val_reg <= in_val;
      in0_reg    <= in0;
      in1_reg    <= in1;
    end
  end


  //----------------------------------------------------------------------
  // Line Tracing
  //----------------------------------------------------------------------

  `ifndef SYNTHESIS

  reg [`VC_TRACE_NBITS-1:0] str;
  `VC_TRACE_BEGIN
  begin

    $sformat( str, "%x|%x", in0, in1 ); // Displays the current cycle's inputs
    vc_trace.append_val_str( trace_str, in_val, str );

    vc_trace.append_str( trace_str, "(" );

    $sformat( str, "%x", in0_reg ); // Displays the inputs that were just registered and produced the current 'out'
    vc_trace.append_val_str( trace_str, in_val_reg, str );
    vc_trace.append_str( trace_str, " " );

    $sformat( str, "%x", in1_reg ); // Displays the inputs that were just registered and produced the current 'out'
    vc_trace.append_val_str( trace_str, in_val_reg, str );

    vc_trace.append_str( trace_str, ")" );

    $sformat( str, "%x", out ); // Displays the current output value
    vc_trace.append_val_str( trace_str, out_val, str ); // Displays the validity of the current output

  end
  `VC_TRACE_END

  `endif /* SYNTHESIS */

endmodule
