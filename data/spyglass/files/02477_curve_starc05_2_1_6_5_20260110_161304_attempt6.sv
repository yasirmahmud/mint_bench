module curve_starc05_2_1_6_5_20260110_161304_attempt6;

  // Declare a 4-element array of 8-bit registers
  reg [7:0] my_array [0:3];

  initial begin
    // Attempt to write to the array using 'z' as an index.
    // This directly violates STARC05-2.1.6.5, which prohibits 'x' or 'z'
    // in array indices.
    my_array[2'bz] = 8'hAA;
  end

endmodule
