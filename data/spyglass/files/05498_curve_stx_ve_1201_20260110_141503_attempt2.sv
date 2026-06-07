module curve_stx_ve_1201_20260110_141503_attempt2 (
  input wire clk,
  input wire rst_n
);

  // First instance of STX_VE_1201 violation
  // Begin label "first_block_start" does not match end label "first_block_end"
  always @(posedge clk) begin : first_block_start
    // Empty block is sufficient to demonstrate the label mismatch
  end : first_block_end

  // Second instance of STX_VE_1201 violation
  // Begin label "second_proc_begin" does not match end label "second_proc_finish"
  always @(negedge rst_n) begin : second_proc_begin
    // Empty block is sufficient to demonstrate the label mismatch
  end : second_proc_finish

endmodule
