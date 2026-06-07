module curve_stx_ve_379_20260110_112349_attempt5 ();

  // Declare an array of 4 8-bit registers, indexed from 1 to 4.
  reg [7:0] my_data_array [1:4];

  initial begin
    // STX_VE_379: Incomplete array/structure literal.
    // The array 'my_data_array' has 4 elements (indices 1, 2, 3, 4).
    // The literal '{1: 8'h11, 3: 8'h33, 4: 8'h44}' provides explicit initial values for elements
    // at index 1, 3, and 4, but *not* for index 2. This makes the literal
    // incomplete for the declared array size and range, triggering STX_VE_379.
    my_data_array = '{1: 8'h11, 3: 8'h33, 4: 8'h44};

    // Dummy usage of array elements to prevent potential unused variable warnings.
    $display("Element 1: %h", my_data_array[1]);
    $display("Element 2: %h", my_data_array[2]);
    $display("Element 3: %h", my_data_array[3]);
    $display("Element 4: %h", my_data_array[4]);
  end

endmodule
