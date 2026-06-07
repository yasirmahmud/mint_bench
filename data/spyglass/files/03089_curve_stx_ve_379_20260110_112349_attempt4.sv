module curve_stx_ve_379_20260110_112349_attempt4 ();

  // Declare an array of 3 integers, indexed from 0 to 2.
  integer my_int_array [0:2];

  initial begin
    // STX_VE_379: Incomplete array/structure literal.
    // The array 'my_int_array' has 3 elements (indices 0, 1, 2).
    // The literal '{0: 10, 2: 30}' provides explicit initial values for elements
    // at index 0 and index 2, but *not* for index 1. This makes the literal
    // incomplete for the declared array size.
    my_int_array = '{0: 10, 2: 30};

    // Dummy usage of array elements to prevent potential unused variable warnings
    // from other linting checks, not directly related to STX_VE_379.
    $display("Element 0: %d", my_int_array[0]);
    $display("Element 1: %d", my_int_array[1]);
    $display("Element 2: %d", my_int_array[2]);
  end

endmodule
