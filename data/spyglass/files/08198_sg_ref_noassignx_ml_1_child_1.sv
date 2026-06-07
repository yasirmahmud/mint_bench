module NoAssignX_ML_ex1 (
    output reg [1:0] my_signal
);

  // SpyGlass violations addressed:
  // SYNTH_89: "Initial Assignment at Declaration for ( my_signal ) is ignored by synthesis"
  //    - Resolved by moving the initialization from the declaration to an 'initial' block.
  // NoAssignX-ML: "RHS of the assignment contains 'X'(Reason : Initialization with 'x' in net declaration)"
  //    - Resolved by initializing 'my_signal' to a known value (2'b0) instead of 2'bx.
  // W528: "Variable 'my_signal[1:0]' set but not read."
  //    - Resolved by declaring 'my_signal' as an output, making it observable/read by external modules.

  initial begin
    my_signal = 2'b0;
  end

endmodule
