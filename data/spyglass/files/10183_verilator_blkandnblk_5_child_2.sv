`timescale 1ns/1ps

module ex5;
  reg e;

  // Added to explicitly 'read' variable 'e' to resolve SpyGlass W528: 'Variable 'e' set but not read.'
  // This provides a clear read operation for linting tools without changing the functional behavior
  // of the initial block or the simulation.
  wire dummy_e_reader = e;

  initial begin
    // The $monitor statement reads 'e' for simulation display purposes.
    // However, some linting tools may not consider system tasks sufficient to resolve W528.
    $monitor("Time=%0t, e=%b", $time, e);
    
    // Both assignments to 'e' are non-blocking ('<=') to resolve the Verilator BLKANDNBLK warning,
    // as described in the problem statement. This maintains consistent simulation behavior.
    e <= 1'b1;
    #1 e <= 1'b0;
    
    // Terminate simulation after observing the changes in 'e'
    #2 $finish;
  end
endmodule
