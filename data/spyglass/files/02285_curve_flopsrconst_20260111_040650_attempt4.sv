module curve_flopsrconst_20260111_040650_attempt4 (
  input wire clk,
  input wire d,
  output reg q
);

  // Declare an active-high asynchronous reset signal
  wire rst_async;

  // Tie the active-high reset signal to its active state (high)
  // This means the reset condition (rst_async) will always be met.
  assign rst_async = 1'b1;

  always @(posedge clk or posedge rst_async) begin
    if (rst_async) begin // This condition will always be true
      q <= 1'b0; // Asynchronously reset q to 0
    end else begin
      q <= d; // Synchronous data path
    end
  end

endmodule
