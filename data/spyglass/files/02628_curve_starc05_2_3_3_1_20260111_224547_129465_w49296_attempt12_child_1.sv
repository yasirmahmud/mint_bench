module curve_starc05_2_3_3_1_20260111_224547_129465_w49296_attempt12 (
  input wire clk_a,
  input wire clk_b,
  input wire rst_s, // Synchronous reset signal
  input wire data_in,
  output reg data_out
);

  // STARC05-2.3.3.1: Edges of multiple clocks used in the same always block.
  // This always block originally listed two distinct clock edges (posedge clk_a and posedge clk_b)
  // in its sensitivity list, which directly triggered the target violation.
  // The issue has been resolved by selecting a single clock (clk_a) for the always block,
  // making the design synthesizable and compliant with single-clock guidelines.
  // The synchronous reset (rst_s) is included and properly handled to prevent the W442a violation.
  always @(posedge clk_a) begin // Fixed: Only one clock edge in sensitivity list to resolve STARC05-2.3.3.1 and W422.
    if (rst_s) begin
      data_out <= 1'b0;
    end else begin
      data_out <= data_in;
    end
  end

endmodule
