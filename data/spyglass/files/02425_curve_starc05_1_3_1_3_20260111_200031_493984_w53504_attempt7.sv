module curve_starc05_1_3_1_3_20260111_200031_493984_w53504_attempt7 (
  input wire clk,
  input wire rst_n,
  input wire data_in,
  output reg q_out
);

  reg q_async;
  reg q_sync_data;

  // rst_n is used as an asynchronous reset for q_async
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      q_async <= 1'b0;
    end else begin
      q_async <= data_in;
    end
  end

  // The same rst_n is used as a data input for q_sync_data
  // This constitutes a "non-reset" usage of an asynchronous reset signal.
  always @(posedge clk) begin
    q_sync_data <= rst_n; // Violation: async reset 'rst_n' used as data
  end

  assign q_out = q_sync_data;

endmodule
