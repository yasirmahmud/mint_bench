module curve_stx_ve_350_20260110_143444_attempt4;

  reg my_reg_signal;
  wire my_wire_signal;

  initial begin
    // STX_VE_350 violation 1: Attempting to disable a 'reg' variable.
    // 'my_reg_signal' is not a task, function, or named procedural block.
    disable my_reg_signal;
  end

  always @(posedge my_reg_signal) begin : some_named_block
    // STX_VE_350 violation 2: Attempting to disable a 'wire' variable.
    // 'my_wire_signal' is not a task, function, or named procedural block.
    disable my_wire_signal;
  end

endmodule
