module curve_synth_12611_20260111_065659_attempt2 (
  input clk_i,
  input data_i,
  output data_o
);

  // Simple combinational logic to ensure inputs/outputs are used and avoid unused signal warnings.
  assign data_o = data_i;

  // This property uses '@(clk_i)' which implies sensitivity to both positive and negative edges
  // of the scalar signal 'clk_i'. This forms a "double-edge clock property" and is explicitly
  // flagged by SYNTH_12611 as it will be ignored for synthesis.
  property p_data_stability_check;
    @(clk_i) (data_i == 1'b1) |-> ##2 (data_i == 1'b0);
  endproperty

endmodule
