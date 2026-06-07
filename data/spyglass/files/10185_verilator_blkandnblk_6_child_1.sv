module ex6 (
  input clk
);
  reg f;

  // Original: always @* f = 1'b1; -- This was a blocking assignment to 'f'
  // Original: always @(posedge clk) f <= 1'b0; -- This was a non-blocking assignment to 'f'
  // The BLKANDNBLK warning indicates that 'f' is driven by both blocking and non-blocking assignments.
  // To resolve this, 'f' must be driven by only one type of assignment.
  // Given that 'f' is declared as 'reg' and has a 'posedge clk' assignment,
  // it is most likely intended to be a sequential element. The combinational
  // blocking assignment is the source of the conflict and non-deterministic behavior.
  // The fix is to remove the conflicting combinational assignment to ensure 'f'
  // is only driven by the sequential non-blocking assignment.
  always @(posedge clk) f <= 1'b0;

  // SpyGlass Violation STX_VE_606: 'clk' was not declared in the current scope.
  // Fix: Added 'clk' as an input to the module.
endmodule
