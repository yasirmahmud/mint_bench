module curve_flopsrconst_20260111_040650_attempt1 (
  input wire clk,
  input wire d,
  output reg q
);

  wire rst_n;

  // Tie the reset signal to a constant value that keeps the flop in reset
  assign rst_n = 1'b0;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin // Active low reset condition
      q <= 1'b0;
    end else begin
      q <= d;
    end
  end

endmodule
