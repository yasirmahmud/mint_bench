module curve_synth_5395_20260112_001708_829702_w6680_attempt19 (
    input wire clk,
    input wire rst,
    input wire event_signal,
    input wire [7:0] data_in,
    output reg [7:0] data_out
);

  // SYNTH_5395 violation: Improper asynchronous style of modeling. Not synthesizable.
  // The sensitivity list includes 'posedge event_signal' alongside 'posedge clk' and 'posedge rst'.
  // 'rst' is handled as an asynchronous reset. However, 'event_signal' being in the asynchronous
  // part of the sensitivity list (i.e., edge-triggered and not 'clk' or a dedicated reset) 
  // makes this an improper asynchronous style. The logic implies that `data_out` can change 
  // on `posedge event_signal` if `rst` is not active, which is typically non-synthesizable 
  // into standard flip-flops.
  always @(posedge clk or posedge rst or posedge event_signal) begin
    if (rst) begin
      data_out <= 8'b0;
    end else begin
      // This block executes on posedge clk OR posedge event_signal.
      // If 'event_signal' rises, and 'rst' is not active, data_out will update, 
      // making 'event_signal' an asynchronous data load, which is non-synthesizable.
      data_out <= data_in;
    end
  end

endmodule
