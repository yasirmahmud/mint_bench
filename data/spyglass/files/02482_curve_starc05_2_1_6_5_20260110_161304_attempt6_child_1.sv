module curve_starc05_2_1_6_5_20260110_161304_attempt6;

  // Declare a 4-element array of 8-bit registers
  reg [7:0] my_array [0:3];
  reg [7:0] read_val; // Added to read the written value and resolve W528

  initial begin
    // Write to the array using a valid index (0).
    // This resolves STARC05-2.1.6.5, which prohibits 'x' or 'z' in array indices.
    my_array[0] = 8'hAA;

    // Read the value back from the array.
    // This resolves W528 (variable set but not read).
    read_val = my_array[0];
  end

endmodule
