module curve_synth_5290_20260111_024903_attempt13 (
  input wire [7:0] in_data,
  output wire [7:0] out_data
);

  // Declare a real parameter. While the declaration itself is typically not a violation,
  // its usage in synthesizable logic will trigger SYNTH_5290.
  parameter real SCALE_FACTOR = 1.5;

  // This assignment performs an arithmetic operation between a bit-vector (in_data)
  // and a real parameter (SCALE_FACTOR). In Verilog, if any operand in an expression
  // is 'real', the entire expression evaluates to a 'real' number.
  // Assigning this 'real' result directly to 'out_data' (which is a synthesizable
  // bit-vector wire) constitutes an "Usage of 'Real' that is not synthesizable".
  // This specific usage triggers the SYNTH_5290 violation.
  assign out_data = in_data * SCALE_FACTOR;

endmodule
