module curve_synth_5034_20260111_195417_451993_w7792_attempt10 (
  input [3:0] data_in,
  output reg  out_val
);

  always @(*) begin
    out_val = 1'b0; // Default assignment to avoid latch

    // SYNTH_5034: Comparison with don't care ('x') using '==' operator will be always false
    // In Verilog, comparing a specific value with a constant containing 'x' using '=='
    // results in an 'X' (unknown) outcome if the bits mismatch or one is 'x'.
    // An 'if (X)' condition is always treated as false in synthesis and simulation.
    if (data_in == 4'b1x10) begin
      out_val = 1'b1;
    end else if (data_in == 4'b0101) begin
      out_val = 1'b0;
    end
  end

endmodule
