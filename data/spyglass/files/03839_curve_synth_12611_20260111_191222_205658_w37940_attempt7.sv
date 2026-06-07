module curve_synth_12611_20260111_191222_205658_w37940_attempt7 (
  input [1:0] clk_bus,
  input data_in,
  output reg out_reg
);

  // Synthesizable logic to use all inputs and avoid W240 (unused signal).
  // Uses clk_bus[0] as a clock, clk_bus[1] as a control signal, and data_in as input.
  always @(posedge clk_bus[0]) begin
    if (clk_bus[1]) begin
      out_reg <= data_in;
    end else begin
      out_reg <= ~data_in;
    end
  end

  // SYNTH_12611: Property blocks will be ignored for synthesis.
  // The clocking event @(clk_bus) for a multi-bit signal ([1:0]) is not
  // synthesizable as a clocking event and is expected to trigger SYNTH_12611.
  property p_multi_bit_clock_event;
    @(clk_bus) data_in |-> ##1 !data_in;
  endproperty

  // No 'assert property' statement is included to avoid SYNTH_5064 (ASSERT statements are not synthesizable).

endmodule
