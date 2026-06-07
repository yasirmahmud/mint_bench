module curve_stx_ve_418_20260111_235931_161779_w25608_attempt16_module (
  input clk,
  input reset_n,
  input data_in,
  output reg data_out
);

  reg internal_data_reg;

  // Synchronous logic to use all inputs and internal registers
  // and avoid other linting violations like unused signals or latches.
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      internal_data_reg <= 1'b0;
      data_out <= 1'b0;
    end else begin
      internal_data_reg <= data_in;
      data_out <= internal_data_reg;
    end
  end

  // STX_VE_418 violation: 'clk' is a primary input and used as the source
  // of a timing path within the specify block, but it is not driven by a
  // gate output within this module. The rule requires an internal gate output
  // as the source for paths defined in the specify block.
  specify
    (clk => internal_data_reg) = 1ps;
  endspecify

endmodule
