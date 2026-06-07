module curve_flopsrconst_20260111_040650_attempt2 (
  input wire clk,
  input wire d,
  output reg q
);

  // Declare an active-high reset signal
  wire rst;

  // Tie the active-high reset signal to its active state (high)
  // This means the reset condition (rst == 1) will always be met.
  assign rst = 1'b1;

  always @(posedge clk or posedge rst) begin
    if (rst) begin // This condition will always be true
      q <= 1'b1; // Resetting q to 1'b1, distinct from previous examples
    end else begin
      q <= d;
    end
  end

endmodule
