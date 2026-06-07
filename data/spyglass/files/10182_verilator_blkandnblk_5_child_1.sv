`timescale 1ns/1ps

module ex5;
  reg e;

  initial begin
    // Add $monitor to read 'e' and resolve W528 'Variable 'e' set but not read.'
    $monitor("Time=%0t, e=%b", $time, e);
    
    // Changed from blocking '=' to non-blocking '<=' to resolve the BLKANDNBLK warning.
    // Both assignments to 'e' are now non-blocking, preserving simulation behavior.
    e <= 1'b1;
    #1 e <= 1'b0;
    
    // Terminate simulation after observing the changes in 'e'
    #2 $finish;
  end
endmodule
