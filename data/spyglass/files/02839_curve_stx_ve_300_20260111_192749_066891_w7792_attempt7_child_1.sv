module curve_stx_ve_300_20260111_192749_066891_w7792_attempt7 ();

  // Declare a SystemVerilog constant integer
  const int MAX_COUNT = 10;

  // Function originally intended to attempt modification of the constant.
  // Verilog-2001 functions implicitly return an integer if not specified.
  // The illegal re-assignment to the module-level 'const' variable has been removed.
  function int set_and_get_max_count_limit();
    // The line 'MAX_COUNT = 20;' was removed to resolve STX_VE_300 (Illegal re-assignment to const variable).
    return MAX_COUNT;
  endfunction

  initial begin
    // Call the function
    set_and_get_max_count_limit();
  end

endmodule
