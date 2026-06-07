module curve_stx_ve_1201_20260110_141503_attempt3 (
  input wire clk
);

  // STX_VE_1201 violation 1 of 2:
  // The begin label 'initial_block_begin_label' does not match the end label 'initial_block_end_label'.
  initial begin : initial_block_begin_label
    $display("Executing initial block.");
  end : initial_block_end_label

  // STX_VE_1201 violation 2 of 2:
  // The begin label 'always_proc_start_label' does not match the end label 'always_proc_finish_label'.
  always @(posedge clk) begin : always_proc_start_label
    reg dummy_q;
    dummy_q <= 1'b0;
  end : always_proc_finish_label

endmodule
