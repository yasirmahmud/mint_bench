module curve_elab_6312_20260111_133615_attempt3 (
  input wire clk,
  input wire clk_en,
  input wire d_in,
  output reg q_out
);

  // The 'iff' construct is a SystemVerilog feature and is not supported in Verilog-2001.
  // Using 'posedge clk iff clk_en' in the sensitivity list will trigger an ELAB_6312 violation.
  // This example uses a single clock edge with 'iff' for a clock enable, distinct from
  // previous attempts that included multiple edges or a reset in the sensitivity list.
  always @(posedge clk iff clk_en) begin
    q_out <= d_in;
  end

endmodule
