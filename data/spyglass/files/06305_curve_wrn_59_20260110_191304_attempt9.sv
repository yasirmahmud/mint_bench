module curve_wrn_59_20260110_191304_attempt9 (
  input wire clk,
  input wire rst,
  input wire data_in,
  output reg data_out
);

  reg internal_reg;

  // This always block describes synthesizable sequential logic (a flip-flop with reset).
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      internal_reg <= 1'b0;
      data_out <= 1'b0;
    end else begin
      // WRN_59: System function ($countdrivers) specified when a system task was expected in this context
      // This rule is triggered because the system function $countdrivers is called
      // without its return value being assigned or used in an expression,
      // making it behave like a system task.
      // Placing it in an otherwise synthesizable 'always' block aims to avoid
      // the SYNTH_5143 warning about 'initial' blocks being ignored for synthesis,
      // as the rest of this block does infer hardware.
      $countdrivers(internal_reg);
      internal_reg <= data_in;
      data_out <= internal_reg;
    end
  end

endmodule
