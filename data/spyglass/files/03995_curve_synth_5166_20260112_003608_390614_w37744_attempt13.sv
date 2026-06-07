module curve_synth_5166_20260112_003608_390614_w37744_attempt13 (
  input wire clk,
  input wire rst_n,
  input wire enable,
  output reg [3:0] counter_out
);

  reg [3:0] counter_reg;

  // SYNTH_5166 violations: $display statements are not synthesizable.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      counter_reg <= 4'h0;
      counter_out <= 4'h0;
      $display("SYNTH_5166 #1: Counter reset at time %t", $time); // First violation
    end else if (enable) begin
      counter_reg <= counter_reg + 1;
      // counter_out reflects the counter_reg value from the beginning of the current cycle
      // (before increment in this same block). This is valid sequential logic.
      counter_out <= counter_reg;
      if (counter_reg == 4'hF) begin
        $display("SYNTH_5166 #2: Counter reached max value and will wrap around at time %t", $time); // Second violation
      end
    end else begin
      // When not enabled, hold the current output and counter value
      counter_out <= counter_reg;
    end
  end

endmodule
