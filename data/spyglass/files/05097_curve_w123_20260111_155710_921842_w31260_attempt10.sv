module curve_w123_20260111_155710_921842_w31260_attempt10 (
  input wire clk,
  input wire reset_n,
  input wire data_in,
  output wire data_out
);

  // Declare 'Q' as an extremely large register (2,097,152 bits wide, i.e., 2^21 bits).
  // This size is intended to be definitively "too big" for default processing
  // by SpyGlass, triggering the W123 rule. Using 'Q' directly matches the rule description
  // "Signal 'Q[1823]' size too big thus not processed...".
  reg [2097151:0] Q; // Corresponds to [2^21-1:0]

  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      // Reset a specific bit of the large register to ensure it is used.
      Q[0] <= 1'b0;
    end else begin
      // Drive another specific bit of 'Q' to ensure the bus is considered used.
      Q[1] <= data_in;
    end
  end

  // Access a bit within the extremely large bus, specifically index 1823 as mentioned
  // in the rule description context. This direct access within the extremely large bus
  // is expected to be the trigger for the W123 violation, as the tool attempts to
  // process this bit but may fail due to the overall size of 'Q' without the
  // 'set_parameter handle_large_bus yes' option.
  assign data_out = Q[1823];

endmodule
