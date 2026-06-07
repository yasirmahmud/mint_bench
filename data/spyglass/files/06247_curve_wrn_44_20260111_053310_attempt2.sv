module curve_wrn_44_20260111_053310_attempt2 ();

  // WRN_44: This function contains a non-blocking assignment.
  // The IEEE Verilog-2001/2005 standards do not support non-blocking assignments within functions.
  function automatic integer my_func_example;
    input integer a;
    integer temp_val; // Declare a local variable within the function
    begin
      // This non-blocking assignment to a local variable inside a function triggers WRN_44.
      // It is a distinct method compared to assigning non-blockingly to the function's return value.
      temp_val <= a + 5;
      my_func_example = temp_val; // Blocking assignment to the function's return value
    end
  endfunction

endmodule
