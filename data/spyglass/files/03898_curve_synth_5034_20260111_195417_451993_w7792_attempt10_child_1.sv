module curve_synth_5034_20260111_195417_451993_w7792_attempt10 (
  input [3:0] data_in,
  output reg  out_val
);

  always @(*) begin
    // As per the SYNTH_5034 violation description, a comparison with 'x' using '=='
    // operator always evaluates to false (X) in Verilog synthesis and simulation.
    // Therefore, the branch 'if (data_in == 4'b1x10)' which sets out_val to 1'b1
    // is effectively dead code and never executed.
    // The subsequent 'else if (data_in == 4'b0101)' branch explicitly sets out_val to 1'b0.
    // Combined with the default assignment, this means out_val is always 1'b0.
    // To preserve the functional behavior (out_val is always 1'b0) and fix the violations,
    // the logic is simplified to an unconditional assignment.
    out_val = 1'b0;
  end

endmodule
