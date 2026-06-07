module curve_flopsrconst_20260111_223313_321972_w49296_attempt11 (
  input clk,
  input d,
  output reg q
);

  // The asynchronous active-low reset 'rst_n' is tied to a constant 1'b0.
  // This makes the flip-flop 'q' always in its reset state, preventing the
  // data path from ever being active. This directly triggers the FlopSRConst
  // rule as the reset pin is effectively tied to a constant (always asserted).
  wire rst_n = 1'b0;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin // This condition is always true, as rst_n is 1'b0
      q <= 1'b0;      // The flip-flop is perpetually held in reset
    end else begin
      q <= d;         // This data path is never taken
    end
  end

endmodule
