module curve_stx_ve_1201_20260110_141503_attempt4;

  // STX_VE_1201 violation 1 of 2:
  // The begin label 'my_initial_start_label' does not match the end label 'my_initial_end_label'.
  initial begin : my_initial_start_label
    $display("Executing initial block.");
  end : my_initial_end_label

  // STX_VE_1201 violation 2 of 2:
  // The begin label 'my_fork_begin_label' does not match the end label 'my_fork_finish_label'.
  fork : my_fork_begin_label
    #1 $display("Executing fork-join block.");
  join : my_fork_finish_label

endmodule
