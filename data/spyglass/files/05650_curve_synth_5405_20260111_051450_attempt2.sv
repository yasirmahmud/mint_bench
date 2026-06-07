module curve_synth_5405_20260111_051450_attempt2 (
  input one_bit_clk_part_a,
  input one_bit_clk_part_b,
  input [7:0] data_in,
  output reg [7:0] data_out
);

  // Concatenate two 1-bit inputs to create a 2-bit wire.
  // This wire will then be used as a "clock" expression.
  wire [1:0] multi_bit_clock_wire;
  assign multi_bit_clock_wire = {one_bit_clk_part_a, one_bit_clk_part_b};

  // This always block uses a multi-bit signal 'multi_bit_clock_wire' as a clock expression.
  // This violates SYNTH_5405 as clock expressions must be one bit wide.
  always @(posedge multi_bit_clock_wire) begin
    data_out <= data_in;
  end

endmodule
