module curve_elab_6312_20260111_230935_254997_w28836_attempt12 (
  input wire clk_i,
  input wire activate_i,
  output reg out_q
);

  // ELAB_6312: The 'iff' construct in an always sensitivity list is a SystemVerilog feature
  // and is not supported in Verilog-2001. This triggers the ELAB_6312 violation.
  // This example uses a negedge clock and a distinct name for the 'iff' condition.
  always @(negedge clk_i iff activate_i) begin
    out_q <= 1'b1; // Simple assignment to ensure the block is not empty
  end

endmodule
