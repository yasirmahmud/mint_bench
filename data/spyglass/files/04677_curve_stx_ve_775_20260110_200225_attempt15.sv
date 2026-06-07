module curve_stx_ve_775_20260110_200225_attempt15 (
  input wire clk,
  output wire out1,
  output wire out2
);

  reg dummy1;
  reg dummy2;

  // STX_VE_775: Initial statement not allowed in this scope
  // A 'specify' block in Verilog-2001 is exclusively for timing constraint
  // declarations. It is not permitted to contain procedural blocks like 'initial'.
  // Placing an 'initial' block here is a specific scope violation.

  specify
    // Violation 1 (Expected Occurrence 1 of 2):
    initial begin // This line is expected to trigger STX_VE_775
      dummy1 = 1'b0;
      $display("STX_VE_775: Initial block 1 in specify block.");
    end
    // A valid timing path to ensure the 'specify' block is otherwise well-formed.
    (clk => out1) = (1, 2);
  endspecify

  // A second specify block to trigger the rule a second time,
  // meeting the 'Total occurrences: 2' requirement.
  specify
    // Violation 2 (Expected Occurrence 2 of 2):
    initial begin // This line is expected to trigger STX_VE_775
      dummy2 = 1'b0;
      $display("STX_VE_775: Initial block 2 in specify block.");
    end
    // Another valid timing path.
    (clk => out2) = (3, 4);
  endspecify

  // Connect outputs to avoid unused signal warnings.
  assign out1 = clk;
  assign out2 = clk;

endmodule
