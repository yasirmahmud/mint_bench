module curve_starc05_2_3_3_1_20260111_224547_129465_w49296_attempt12 (
  input wire clk_a,
  input wire clk_b,
  input wire rst_s, // Synchronous reset signal
  input wire data_in,
  output reg data_out
);

  // STARC05-2.3.3.1: Edges of multiple clocks used in the same always block.
  // This always block explicitly lists two distinct clock edges (posedge clk_a and posedge clk_b)
  // in its sensitivity list, which directly triggers the target violation.
  // A synchronous reset (rst_s) is included and properly handled to prevent the W442a violation
  // (Asynchronously reset/set always block has missing 'if' statement) seen in previous attempts.
  // All signals are used, widths are matched, no implicit nets or latches are created.
  always @(posedge clk_a or posedge clk_b) begin
    if (rst_s) begin
      data_out <= 1'b0;
    end else begin
      data_out <= data_in;
    end
  end

endmodule
