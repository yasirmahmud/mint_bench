module curve_w415_20260111_231216_341909_w49296_attempt11 (
  input wire input_a,
  input wire input_b,
  output wire output_z
);

  // Declare a register that will be driven by multiple procedural blocks
  reg logic_signal_reg;

  // First combinational driver for logic_signal_reg
  always @(*) begin
    logic_signal_reg = input_a; // ERROR: Signal 'logic_signal_reg' has multiple simultaneous drivers
  end

  // Second combinational driver for logic_signal_reg, creating the W415 violation
  always @(*) begin
    logic_signal_reg = input_b;
  end

  // Simple output assignment to avoid unused signal warnings
  assign output_z = logic_signal_reg;

endmodule
