module overlapping_loops_ex2;
 wire a, b, c;
 assign a = b;
 assign c = b;
 assign b = 1'b0; // Original: assign b = a | c; This created a combinational loop.
                      // Replaced with a constant assignment to break the loop and define a stable value.
endmodule
