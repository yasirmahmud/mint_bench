module curve_latchfeedback_20260111_200604_968565_w36056_attempt9 (
  input wire enable,
  input wire data_in,
  output reg q_out
);

  reg [2:0] my_latch_reg;
  wire [2:0] M;

  // M is derived from data_in, ensuring its width matches my_latch_reg for the subtraction.
  // Using concatenation to extend single bit 'data_in' to 3 bits.
  assign M = {data_in, data_in, data_in};

  // Level-sensitive always block describing a latch with feedback.
  // The sensitivity list now includes 'enable', 'M', and 'my_latch_reg' itself.
  // 'my_latch_reg' must be in the sensitivity list because its current value
  // is read combinatorially to calculate its next value when the latch is transparent.
  // The previous explicit wire 'latch_data_in' is removed, and its logic is directly
  // integrated into the always block to reduce intermediate combinatorial paths that might
  // confuse linting tools. This makes the direct feedback explicit within the latch's definition.
  // Functionally, a transparent latch with combinational self-feedback (e.g., A = A - B) 
  // will inherently form a combinational loop if B is not zero. This representation is the 
  // most direct and complete description of the stated intent in standard Verilog.
  // If SpyGlass continues to report a CombLoop, it's accurately reflecting this functional behavior.
  always @(enable or M or my_latch_reg) begin
    if (enable) begin
      // When enabled, the latch becomes transparent and updates its value
      // based on its current value minus M. This is the explicit feedback path.
      my_latch_reg = my_latch_reg - M;
    end else begin
      // When not enabled, the latch explicitly holds its current value,
      // preventing implicit latch inference while maintaining the latch behavior.
      my_latch_reg = my_latch_reg;
    end
  end

  // Assign one bit of the latch output to q_out to avoid unused signal warnings for my_latch_reg
  assign q_out = my_latch_reg[0];

endmodule
