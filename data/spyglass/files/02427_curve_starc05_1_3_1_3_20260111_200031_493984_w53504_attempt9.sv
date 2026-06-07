module curve_starc05_1_3_1_3_20260111_200031_493984_w53504_attempt9 (
  input wire clk,
  input wire rst,        // Active high asynchronous reset
  input wire data_in,
  output reg q_out
);

  reg async_flop;
  reg sync_data_flop;

  // 'rst' is defined as an asynchronous reset for 'async_flop'
  always @(posedge clk or posedge rst) begin
    if (rst) begin // Asynchronous reset condition
      async_flop <= 1'b0;
    end else begin
      async_flop <= data_in;
    end
  end

  // The same 'rst' signal (an async reset for 'async_flop')
  // is used as a synchronous enable for 'sync_data_flop'.
  // This triggers STARC05-1.3.1.3 as it's a non-reset/synchronous-reset usage.
  always @(posedge clk) begin
    if (rst) begin // 'rst' acts as a synchronous enable here
      sync_data_flop <= async_flop;
    end else begin
      sync_data_flop <= 1'b0;
    end
  end

  // Use all internal registers to avoid unused signal warnings
  always @(posedge clk) begin
    q_out <= async_flop ^ sync_data_flop;
  end

endmodule
