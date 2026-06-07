module curve_starc05_1_3_1_3_20260111_230342_988292_w15680_attempt12 (
  input wire clk,
  input wire rst, // Active-high reset
  input wire data_in,
  output reg out_async,
  output reg out_data
);

  // This block defines 'rst' as an active-high asynchronous reset for 'out_async'
  always @(posedge clk or posedge rst) begin
    if (rst) begin // Asynchronous reset condition
      out_async <= 1'b0;
    end else begin
      out_async <= data_in;
    end
  end

  // This block uses 'rst' as an enable signal for 'out_data'.
  // This usage conflicts with its asynchronous reset role for 'out_async',
  // triggering STARC05-1.3.1.3 (used as non-reset logic when defined as asynchronous reset elsewhere).
  always @(posedge clk) begin
    if (rst) begin // 'rst' acts as an active-high enable here
      out_data <= data_in;
    end else begin
      out_data <= out_data; // Hold previous value
    end
  end

endmodule
