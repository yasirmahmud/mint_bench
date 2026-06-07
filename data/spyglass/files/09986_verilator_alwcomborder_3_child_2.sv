module example_03 (
  input a,
  output y // Changed from output reg y for Verilog-2001 compatibility
);
  reg y; // 'y' must be declared 'reg' if assigned in an always block

  // The 'reg state;' declaration is removed, as it's no longer needed.
  // This directly addresses the ALWCOMBORDER warning associated with 'state'
  // by eliminating the intermediate variable.

  always @* begin // Changed from always_comb to always @* for Verilog-2001 compatibility
    if (a) y = 1'b1; // Directly using 'a' to determine 'y', eliminating the intermediate 'state'
    else y = 1'b0;
  end
endmodule
