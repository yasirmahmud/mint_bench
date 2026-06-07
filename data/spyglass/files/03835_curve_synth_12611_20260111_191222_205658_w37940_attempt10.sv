module curve_synth_12611_20260111_191222_205658_w37940_attempt10 (
  input clk,
  input data_in,
  output reg data_out
);

  // Minimal synthesizable logic to avoid unused signal warnings (e.g., W240)
  // and ensure all ports are used. This creates a simple D-flip-flop.
  always @(posedge clk) begin
    data_out <= data_in;
  end

  // SYNTH_12611: Property blocks will be ignored for synthesis.
  // Using `@(clk)` on a single-bit signal `clk` within a SystemVerilog property context
  // is often interpreted as `@(edge clk)`, which implicitly creates a double-edge clocking event.
  // Such double-edge clocking events or general property usage are not synthesizable
  // and lead to the SYNTH_12611 warning, indicating the property block will be ignored by synthesis tools.
  // This example uses a simple assertion (data_in |-> data_out) within the property
  // to be distinct from previous attempts while retaining the core violation mechanism.
  property p_simple_double_edge_clock;
    @(clk) data_in |-> data_out;
  endproperty

  // No 'assert property' statement is included to avoid SYNTH_5064 (ASSERT statements are not synthesizable).

endmodule
