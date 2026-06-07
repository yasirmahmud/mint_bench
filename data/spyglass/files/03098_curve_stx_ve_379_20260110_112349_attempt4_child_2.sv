module curve_stx_ve_379_20260110_112349_attempt4 ();

  // Declare an array of 3 integers, indexed from 0 to 2.
  integer my_int_array [0:2];

  initial begin
    // WRN_1470: The construct 'array pattern keys in assignment patterns'
    // is not supported in some tools. The original code used '{0: 10, 2: 30, default: 0}'.
    // This has been replaced with individual element assignments to ensure compatibility
    // and resolve WRN_1470, while maintaining the same functional initialization.
    // This also implicitly addresses STX_VE_379 by ensuring all elements have an explicit value.
    my_int_array[0] = 10;
    my_int_array[1] = 0; // Explicitly set element 1 to the default value
    my_int_array[2] = 30;

    // The W528 warning (variable set but not read) should be resolved because
    // each array element is now individually assigned and subsequently read by the $display statements.

    // SYNTH_5143 (initial block ignored for synthesis) is expected for simulation-only
    // 'integer' variables initialized in an 'initial' block and is retained to preserve
    // the simulation-specific functional behavior as described.

    $display("Element 0: %d", my_int_array[0]);
    $display("Element 1: %d", my_int_array[1]);
    $display("Element 2: %d", my_int_array[2]);
  end

endmodule
