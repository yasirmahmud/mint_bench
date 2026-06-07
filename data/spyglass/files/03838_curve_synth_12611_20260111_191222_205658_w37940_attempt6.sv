module curve_synth_12611_20260111_191222_205658_w37940_attempt6 (
  input logic [1:0] clk_bus,
  input logic data_in
);

  // SYNTH_12611: Property blocks will be ignored for synthesis
  property p_multi_bit_clock_event;
    @(clk_bus) data_in |-> ##1 !data_in;
  endproperty

  ap_multi_bit_clock_event : assert property (p_multi_bit_clock_event);

endmodule
