module curve_synth_5405_20260111_223847_659004_w28836_attempt12 (
  input        clk_bit0,
  input        clk_bit1,
  input        clk_bit2,
  input        clk_bit3,
  input        data_in,
  output reg   data_out
);

  localparam CLK_WIDTH = 4;
  reg [CLK_WIDTH-1:0] composite_clock;

  // Drive the multi-bit 'reg' combinatorially from single-bit inputs.
  // This ensures 'composite_clock' is always driven and avoids latch inference.
  always @(*) begin
    composite_clock = {clk_bit3, clk_bit2, clk_bit1, clk_bit0};
  end

  // SYNTH_5405 violation: Clock expression 'composite_clock' must be one bit wide.
  // This rule is triggered because the 'composite_clock' signal, which is 4 bits wide,
  // is used directly as the clock in an 'always @(posedge ...)' sensitivity list.
  // The rule specifically requires clock expressions to be one bit wide.
  // FIX: The clock expression has been changed to 'clk_bit0', which is a single-bit input.
  // This resolves the SYNTH_5405 and W218 violations by providing a synthesizable single-bit clock.
  always @(posedge clk_bit0) begin
    data_out <= data_in;
  end

endmodule
