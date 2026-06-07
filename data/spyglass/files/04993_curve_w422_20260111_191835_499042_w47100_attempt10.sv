module curve_w422_20260111_191835_499042_w47100_attempt10 (
  input clk_in,
  input data_in,
  output reg data_out_reg
);

  // W422 violation: The event control list for this always block uses both 'posedge clk_in' and 'negedge clk_in'.
  // While both edges relate to the *same* physical clock signal, using both rising and falling edges
  // in a single sequential always block is generally not synthesizable into standard flip-flops.
  // Many synthesis tools will interpret this as an ambiguous or incompatible clocking scheme for a single block,
  // leading to the "event control has more than one clock" violation (W422).
  // This setup aims to trigger W422 by violating the single-edge-per-clock rule within a block,
  // while avoiding STARC05-2.3.3.1 which is typically concerned with multiple *distinct* clock signals.
  always @(posedge clk_in or negedge clk_in) begin
    // This assignment attempts to respond to both clock edges, which is problematic for standard synthesis.
    // The assignment ensures no latches are inferred by covering all conditions.
    data_out_reg <= data_in;
  end

endmodule
