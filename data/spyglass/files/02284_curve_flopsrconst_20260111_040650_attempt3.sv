module curve_flopsrconst_20260111_040650_attempt3 (
  input wire clk,
  input wire d,
  output reg q
);

  // Declare an active-low asynchronous reset signal
  wire rst_n;

  // Tie the active-low reset signal to its active state (low)
  // This means the reset condition (!rst_n) will always be met.
  assign rst_n = 1'b0;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin // This condition will always be true
      q <= 1'b0; // Asynchronously reset q to 0
    end else begin
      q <= d; // Synchronous data path
    end
  end

endmodule
