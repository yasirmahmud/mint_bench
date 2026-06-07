module curve_synth_12611_20260111_191222_205658_w37940_attempt8 (
  input [2:0] main_clk_bus,
  input data_in_i,
  output reg data_out_o
);

  // Synthesizable logic to use inputs and outputs, avoid unused signal warnings (e.g., W240).
  // Uses main_clk_bus[0] as clock, main_clk_bus[1] as synchronous reset, and data_in_i as data.
  always @(posedge main_clk_bus[0]) begin
    if (main_clk_bus[1]) begin // Synchronous reset
      data_out_o <= 1'b0;
    end else begin
      data_out_o <= data_in_i;
    end
  end

  // SYNTH_12611: Property blocks will be ignored for synthesis.
  // The clocking event @(main_clk_bus) for a multi-bit signal ([2:0]) is not
  // synthesizable as a clocking event and is expected to trigger SYNTH_12611.
  property p_triple_bit_clock_event;
    @(main_clk_bus) data_in_i |-> ##1 !data_in_i;
  endproperty

  // No 'assert property' statement is included to avoid SYNTH_5064 (ASSERT statements are not synthesizable).

endmodule
