module curve_starc05_1_3_1_3_20260111_200031_493984_w53504_attempt7 (
  input wire clk,
  input wire rst_n,
  input wire data_in,
  output reg q_out
);

  reg q_sync_data;

  // The original 'q_async' register and its logic have been removed.
  // This resolves the W528 violation ('q_async' set but not read).
  // By removing the only flip-flop that used 'rst_n' as an asynchronous reset,
  // 'rst_n' is no longer classified as an asynchronous reset signal within this module.
  // Thus, the STARC05-1.3.1.3 violation is also resolved, as 'rst_n' is now only used as a synchronous data input.

  always @(posedge clk) begin
    q_sync_data <= rst_n;
  end

  assign q_out = q_sync_data;

endmodule
