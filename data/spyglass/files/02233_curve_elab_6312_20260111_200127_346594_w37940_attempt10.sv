module curve_elab_6312_20260111_200127_346594_w37940_attempt10 (
  input wire clk_i,
  input wire enable_i,
  output reg data_o
);

  // The 'iff' construct in an always sensitivity list is a SystemVerilog feature
  // not supported in Verilog-2001, directly triggering ELAB_6312.
  // This example uses a positive edge and a single 'iff' condition, distinct from previous attempts.
  always @(posedge clk_i iff enable_i) begin
    data_o <= ~data_o; // Simple toggle to ensure block is not empty
  end

endmodule
