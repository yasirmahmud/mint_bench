module curve_synth_126_20260111_222530_067553_w32456_attempt11 (
  input clk,
  input in_val,
  output out_val
);

  reg reg_data; // Declared as reg to be assigned procedurally

  // This 'assign' statement placed inside an 'always @(negedge clk)' block
  // is a procedural continuous assign and triggers SYNTH_126.
  always @(negedge clk) begin
    assign reg_data = in_val;
  end

  // Using reg_data to ensure it is not optimized away as an unused signal.
  assign out_val = reg_data;

endmodule
