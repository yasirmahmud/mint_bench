module curve_flopsrconst_20260111_223313_321972_w49296_attempt12 (
  input clk,
  input d,
  output reg q
);

  // An asynchronous active-high reset 'rst_p' is tied to a constant 1'b1.
  // This causes the reset pin to be perpetually asserted.
  wire rst_p = 1'b1;

  always @(posedge clk or posedge rst_p) begin
    if (rst_p) begin // This condition is always true, as rst_p is 1'b1
      q <= 1'b0;      // The flip-flop is perpetually held in its reset state
    end else begin
      q <= d;         // This data path is never taken
    end
  end

endmodule
