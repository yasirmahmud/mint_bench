module curve_stx_ve_418_20260111_235931_161779_w25608_attempt17 (
  input clk,
  input reset_n,
  input data_in,
  output reg output_reg
);

  // Synchronous logic to use all inputs and drive the output register.
  // This avoids unused signals, latches, and implicit nets.
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      output_reg <= 1'b0;
    end else begin
      output_reg <= data_in;
    end
  end

  // STX_VE_418 violation: 'clk' is a primary input and used as the source
  // of a timing path within the specify block. The rule requires that the source
  // of a path must be driven by an internal gate output, not directly by a primary input.
  specify
    (clk => output_reg) = 1ps;
  endspecify

endmodule
