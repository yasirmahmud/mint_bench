module curve_stx_ve_418_20260111_235931_161779_w25608_attempt15_module (
  input clk,
  input reset_n,
  input data_in,
  output reg data_out
);

  reg internal_reg_a;

  // Synchronous logic to use all inputs and internal registers
  // and avoid other linting violations like unused signals or latches.
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      internal_reg_a <= 1'b0;
      data_out <= 1'b0;
    end else begin
      internal_reg_a <= data_in; // Use data_in
      data_out <= internal_reg_a; // Use internal_reg_a and drive output
    end
  end

  // STX_VE_418 violation: The source of the timing path (data_in)
  // is a primary input and not driven by a gate output within the design.
  specify
    (data_in => internal_reg_a) = 1ps;
  endspecify

endmodule
