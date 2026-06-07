module curve_synth_126_20260111_184224_680196_w37940_attempt8 (
  input a,
  input b,
  output reg out_val
);

  reg internal_reg;

  // SYNTH_126: Procedural continuous assign statements are not synthesizable.
  // An 'assign' statement within an 'always' block is a procedural continuous assign.
  always @(a or b) begin
    assign internal_reg = a && b;
  end

  assign out_val = internal_reg;

endmodule
