module curve_stx_ve_775_20260110_200225_attempt15 (
  input wire clk,
  output wire out1,
  output wire out2
);

  reg dummy1;
  reg dummy2;

  // STX_VE_775: Initial statement not allowed in this scope
  // The initial blocks have been moved out of the specify scope to resolve this violation.
  // This preserves the initialization of 'dummy1' and 'dummy2' and the display messages.
  initial begin
    dummy1 = 1'b0;
    $display("STX_VE_775: Initial block 1 content moved from specify block.");
    dummy2 = 1'b0;
    $display("STX_VE_775: Initial block 2 content moved from specify block.");
  end

  specify
    // Violation 1 (Expected Occurrence 1 of 2) for STX_VE_775 is resolved.
    // A valid timing path to ensure the 'specify' block is otherwise well-formed.
    (clk => out1) = (1, 2);
  endspecify

  // A second specify block, with initial block removed, to resolve the second STX_VE_775 occurrence.
  specify
    // Violation 2 (Expected Occurrence 2 of 2) for STX_VE_775 is resolved.
    // Another valid timing path.
    (clk => out2) = (3, 4);
  endspecify

  // Connect outputs to avoid unused signal warnings.
  assign out1 = clk;
  assign out2 = clk;

endmodule
