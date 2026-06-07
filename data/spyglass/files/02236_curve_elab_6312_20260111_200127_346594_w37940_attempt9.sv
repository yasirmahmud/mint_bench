module curve_elab_6312_20260111_200127_346594_w37940_attempt9 (
  input clk_i,
  input gate_i,
  output reg data_o
);

  // The 'iff' construct in an always sensitivity list is a SystemVerilog feature
  // not supported in Verilog-2001, directly triggering ELAB_6312.
  // This example uses negedge and a different assignment to be distinct from previous attempts.
  always @(negedge clk_i iff gate_i) begin
    data_o <= 1'b1; // Simple assignment to ensure the block is not empty
  end

endmodule
