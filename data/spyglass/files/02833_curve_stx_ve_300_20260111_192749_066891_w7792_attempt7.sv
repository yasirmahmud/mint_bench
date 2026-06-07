module curve_stx_ve_300_20260111_192749_066891_w7792_attempt7 ();

  // Declare a SystemVerilog constant integer
  const int MAX_COUNT = 10;

  // Function to attempt modification of the constant
  // Verilog-2001 functions implicitly return an integer if not specified.
  // This function attempts to re-assign the module-level 'const' variable.
  function int set_and_get_max_count_limit();
    // Illegal re-assignment to the constant variable
    MAX_COUNT = 20; // This line triggers STX_VE_300
    return MAX_COUNT; // Dummy return, though not strictly required for the violation
  endfunction

  initial begin
    // Call the function to execute the re-assignment within it
    set_and_get_max_count_limit();
  end

endmodule
