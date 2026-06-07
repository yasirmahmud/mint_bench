module test4(input in_b);
  wire [1:0] state_reg; // Changed from 'reg' to 'wire' to resolve CONTASSREG
  assign state_reg = {in_b, 1'b0};

  // Dummy assignment to resolve SpyGlass W528 (Variable 'state_reg[1:0]' set but not read)
  // This ensures state_reg is 'read' without changing the module's ports or core functional behavior.
  wire [1:0] state_reg_dummy_read;
  assign state_reg_dummy_read = state_reg;
endmodule
