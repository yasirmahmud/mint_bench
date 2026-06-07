module curve_synth_12611_20260111_065659_attempt4 (
  input clk_i,
  input data_i,
  output reg data_o
);

  // Synthesizable logic to ensure clk_i, data_i, and data_o are used,
  // preventing 'unused signal' warnings (e.g., W240).
  always @(posedge clk_i) begin
    data_o <= data_i;
  end

  // This property uses '@(clk_i)' for a scalar input 'clk_i'.
  // In Verilog-2001, for a scalar (bit/logic) signal, '@(signal)' is
  // equivalent to '@(edge signal)', which infers sensitivity to both
  // positive and negative edges. This creates a "double-edge clock property".
  // Such properties are typically ignored by synthesis tools, triggering SYNTH_12611.
  property p_double_edge_property;
    @(clk_i) (data_i == 1'b1) |-> ##1 (data_o == 1'b1);
  endproperty

  // The property is declared but not asserted. This ensures SYNTH_12611 is
  // triggered by the property's definition itself, but avoids SYNTH_5064
  // (ASSERT statements are not synthesizable) which was seen in previous attempts.

endmodule
