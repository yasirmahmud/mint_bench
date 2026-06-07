module test4(input in_b);
  wire [1:0] state_reg; // Changed from 'reg' to 'wire' to resolve CONTASSREG
  assign state_reg = {in_b, 1'b0};

  // The dummy assignment to 'state_reg_dummy_read' and its declaration have been removed.
  // This resolves the SpyGlass W528 violation for 'state_reg_dummy_read' (set but not read),
  // as 'state_reg_dummy_read' itself was only introduced to satisfy a previous linting rule for 'state_reg'.
  // This change strictly addresses the reported violation without altering the core functional behavior.
endmodule
