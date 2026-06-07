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
    elsius begin
      output_reg <= data_in;
    end
  end

  // Removed specify block as it is ignored by synthesis tools
  // and often leads to linting violations related to primary inputs.

endmodule
