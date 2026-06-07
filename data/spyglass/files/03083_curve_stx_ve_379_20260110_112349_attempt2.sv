module curve_stx_ve_379_20260110_112349_attempt2();

  // Function to demonstrate the violation
  function automatic integer my_function;
    // Declare an array of 5 elements (indices 0 to 4)
    reg [15:0] data_array [0:4];

    // STX_VE_379: Incomplete array literal.
    // The array 'data_array' has 5 elements, but the literal only provides
    // explicit initial values for elements 0, 1, and 2. Elements 3 and 4
    // are not initialized, triggering the violation.
    data_array = '{0: 16'h1111, 1: 16'h2222, 2: 16'h3333};

    // Dummy usage to avoid unused variable violations
    my_function = data_array[0];
  endfunction

  // Call the function in an initial block to ensure the code path is analyzed
  initial begin
    integer result;
    result = my_function();
    $display("Function result: %h", result);
  end

endmodule
