module curve_stx_ve_418_20260111_235931_161779_w25608_attempt18 (
  input clk,
  input reset_n,
  input data_in,
  output output_signal
);

  // Declare an internal register. This will be the destination of our specify path.
  reg internal_reg;

  // Synchronous logic to use all inputs and drive the internal register.
  // This avoids unused signals, latches, and implicit nets.
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      internal_reg <= 1'b0;
    end else begin
      internal_reg <= data_in;
    end
  end

  // Connect the internal register to the output port.
  // This ensures 'internal_reg' is used and 'output_signal' is driven.
  assign output_signal = internal_reg;

  // STX_VE_418 violation:
  // 'clk' is a primary input and used as the source of a timing path within the specify block.
  // The rule states that the path source must be driven by a gate output, not directly by a primary input.
  // Using an internal register ('internal_reg') as the destination that is not directly an output port
  // makes this example distinct from previous attempts that used the output port directly.
  specify
    (clk => internal_reg) = 1ps;
  endspecify

endmodule
