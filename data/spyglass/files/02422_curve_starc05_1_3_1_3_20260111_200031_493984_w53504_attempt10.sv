module curve_starc05_1_3_1_3_20260111_200031_493984_w53504_attempt10 (
  input wire clk,
  input wire rst_n, // Active low asynchronous reset
  input wire data_in,
  output reg q_out
);

  reg reg_async_rst_for_this; // This flop uses rst_n as an async reset
  reg reg_sync_rst_for_this;  // This flop uses rst_n as a sync reset

  // 'rst_n' is defined as an active-low asynchronous reset for 'reg_async_rst_for_this'
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin // Asynchronous reset condition
      reg_async_rst_for_this <= 1'b0;
    end else begin
      reg_async_rst_for_this <= data_in;
    end
  end

  // The same 'rst_n' signal (an async reset for 'reg_async_rst_for_this')
  // is used as an active-low SYNCHRONOUS RESET for 'reg_sync_rst_for_this'.
  // This triggers STARC05-1.3.1.3 as it's a "synchronous-reset" usage
  // for a signal that is already declared as an asynchronous reset for another flop.
  always @(posedge clk) begin
    if (!rst_n) begin // 'rst_n' acts as an active-low synchronous reset here
      reg_sync_rst_for_this <= 1'b0;
    end else begin
      reg_sync_rst_for_this <= reg_async_rst_for_this;
    end
  end

  // Connect outputs to internal registers to avoid unused signal warnings
  always @(posedge clk) begin
    q_out <= reg_async_rst_for_this ^ reg_sync_rst_for_this;
  end

endmodule
