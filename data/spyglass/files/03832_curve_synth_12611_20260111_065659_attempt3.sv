module curve_synth_12611_20260111_065659_attempt3 (
  input clk_i,
  input data_i,
  output reg data_o
);

  // Synthesizable logic to ensure clk_i, data_i, and data_o are used
  // and avoid 'unused signal' warnings (e.g., W240).
  always @(posedge clk_i) begin
    data_o <= data_i;
  end

  // This property uses '@(clk_i)' for a scalar signal 'clk_i'.
  // In Verilog, '@(clk_i)' for a bit/logic type is equivalent to '@(edge clk_i)',
  // which implicitly infers sensitivity to both positive and negative edges.
  // This constitutes a "double-edge clock property", triggering SYNTH_12611
  // as such properties are typically ignored by synthesis tools.
  property p_data_stability_check;
    @(clk_i) (data_i === 1'b1) |-> ##1 (data_o === 1'b1);
  endproperty

  // Assert the property. While not strictly required for the SYNTH_12611 violation
  // (which is triggered by the property's declaration itself), it's good practice
  // and ensures the property is part of the design context.
  assert property (p_data_stability_check);

endmodule
