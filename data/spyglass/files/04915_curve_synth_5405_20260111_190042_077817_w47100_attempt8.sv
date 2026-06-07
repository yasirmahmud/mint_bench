module curve_synth_5405_20260111_190042_077817_w47100_attempt8 (
  input wire [1:0] raw_clock_in // A multi-bit input that will eventually drive the clock expression
);

  localparam CLK_WIDTH = 2; // Define the multi-bit width for clarity

  // Declare an internal multi-bit register that will serve as the clock expression
  reg [CLK_WIDTH-1:0] internal_multi_bit_clk;

  // Combinational logic to drive the internal multi-bit clock register from the input.
  // This ensures 'internal_multi_bit_clk' is a valid, driven signal and avoids unused input/signal warnings.
  always @(*) begin
    internal_multi_bit_clk = raw_clock_in;
  end

  // SYNTH_5405 violation:
  // The 'posedge' edge specification is applied to 'internal_multi_bit_clk',
  // which is a multi-bit expression (2 bits wide in this case).
  // SpyGlass expects clock expressions in 'always @(posedge/negedge ...)' to be one bit wide.
  always @(posedge internal_multi_bit_clk) begin
    // An empty block is used to ensure minimality and to avoid introducing other rules
    // related to data path assignments or latch inference.
  end

endmodule
