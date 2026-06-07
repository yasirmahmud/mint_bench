module curve_wrn_44_20260111_053310_attempt3 ();

  // WRN_44: Non-blocking assignment statement in a function.
  // The IEEE 1364-2001/2005 Verilog standards do not support this.
  function automatic integer my_func_with_nba;
    input integer input_val;
    begin
      // This non-blocking assignment (<=) directly to the function's return value
      // 'my_func_with_nba' inside the function definition body will trigger WRN_44.
      my_func_with_nba <= input_val + 1;
    end
  endfunction

endmodule
