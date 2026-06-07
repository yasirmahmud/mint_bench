module curve_stx_ve_1201_20260110_141503_attempt4;

  // STX_VE_1201 violation 1 of 2 fixed: End label now matches begin label.
  initial begin : my_initial_start_label
    $display("Executing initial block.");
  end : my_initial_start_label

  // STX_VE_1201 violation 2 of 2 fixed: End label now matches begin label.
  // STX_VE_481 is also expected to be resolved as it was likely a consequence of the label mismatch.
  fork : my_fork_begin_label
    #1 $display("Executing fork-join block.");
  join : my_fork_begin_label

endmodule
