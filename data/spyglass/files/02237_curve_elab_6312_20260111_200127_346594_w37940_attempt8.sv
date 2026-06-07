module curve_elab_6312_20260111_200127_346594_w37940_attempt8 (
  input main_clk,
  input gate_en,
  output reg output_q
);

  // The 'iff' construct in an always sensitivity list is a SystemVerilog feature
  // not supported in Verilog-2001, directly triggering ELAB_6312.
  always @(posedge main_clk iff gate_en) begin
    output_q <= 1'b0; // Simple assignment to ensure the block is not empty
  end

endmodule
