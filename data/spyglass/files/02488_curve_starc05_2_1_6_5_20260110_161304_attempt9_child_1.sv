module curve_starc05_2_1_6_5_20260110_161304_attempt9 ();

  // Declare a memory with 8 elements, each 4 bits wide
  reg [3:0] my_memory [0:7];

  initial begin
    // STARC05-2.1.6.5 violation: Using 'x' as an array index
    // A 3-bit index (e.g., 3'b000 to 3'b111) is appropriate for 8 elements.
    // Fixed: Replaced 'x' with a valid index (0) to resolve STARC05-2.1.6.5.
    // This ensures a defined memory access while maintaining the intent of an assignment.
    my_memory[0] = 4'hF;
  end

endmodule
