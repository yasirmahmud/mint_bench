module curve_stx_ve_379_20260110_112349_attempt1();

  // Declare an array of 4 elements
  reg [7:0] my_array [0:3];

  initial begin
    // STX_VE_379: Incomplete array literal.
    // The array 'my_array' has 4 elements (0 to 3), but the literal only
    // provides initial values for elements 0 and 1. Fixed by using 'default' to
    // explicitly assign values to all remaining elements, thus completing the literal.
    my_array = '{0: 8'hAA, 1: 8'hBB, default: 8'h00};

    // Dummy usage to avoid unused signal violation for my_array
    $display("Array element 0: %h", my_array[0]);
  end

endmodule
