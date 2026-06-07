module curve_starc05_1_3_1_3_20260111_230342_988292_w15680_attempt11 (
  input wire clk,
  input wire rst_n,
  input wire data_in,
  output reg out_async,
  output reg out_sync_en
);

  // This block defines 'rst_n' as an active-low asynchronous reset for 'out_async'
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin // Asynchronous reset condition
      out_async <= 1'b0;
    end else begin
      out_async <= data_in;
    end
  end

  // This block uses 'rst_n' as an active-low synchronous reset for 'out_sync_en'
  // This usage conflicts with its asynchronous reset role for 'out_async',
  // triggering STARC05-1.3.1.3 (used as synchronous reset when defined as asynchronous reset elsewhere).
  always @(posedge clk) begin
    if (!rst_n) begin // Synchronous reset condition
      out_sync_en <= 1'b0;
    end else begin
      out_sync_en <= data_in;
    end
  end

endmodule
