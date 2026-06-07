module curve_starc05_2_3_1_6_20260111_224021_008822_w32456_attempt11 (
  input wire clk,
  input wire rst_async,
  input wire data_in,
  output reg q_out
);

  // STARC05-2.3.1.6 violation: The reset edge in the sensitivity list (posedge rst_async)
  // implies an active-high asynchronous reset. However, the reset condition checks for
  // 'rst_async == 1'b0', which is an active-low logic level.
  always @(posedge clk or posedge rst_async) begin
    if (rst_async == 1'b0) begin // Mismatch: 'posedge rst_async' but checks for active-low
      q_out <= 1'b0;
    end else begin
      q_out <= data_in;
    end
  end

endmodule
