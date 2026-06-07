module curve_synth_12611_20260111_065659_attempt1 (
  input clk,
  input reset_n,
  input data_in,
  output reg data_out
);

  // Basic sequential logic to ensure inputs/outputs are used
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      data_out <= 1'b0;
    end else begin
      data_out <= data_in;
    end
  end

  // This property uses '@(clk)' which implies sensitivity to both positive and negative edges.
  // In Verilog-2001, for a scalar signal like 'clk', '@(clk)' triggers on any change (0->1 or 1->0).
  // This forms a "double-edge clock property" and is explicitly flagged by SYNTH_12611.
  property p_double_edge_check;
    @(clk) data_in |-> ##1 !data_in;
  endproperty

endmodule
