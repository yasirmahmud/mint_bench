module curve_stx_ve_850_20260111_124711_attempt11 (
  input wire clk
);

  // This task is intentionally left unclosed to trigger STX_VE_850.
  // The file ends with 'endmodule', but the parser is still expecting 'endtask'.
  task my_incomplete_task;
    // Missing 'endtask' here, causing premature end of a construct.
    // The parser will encounter 'endmodule' while still in the task context.

endmodule
