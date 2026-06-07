module curve_wrn_44_mod_attempt9 (
  input integer in_val,
  output integer out_val
);

  // Function to trigger WRN_44: Non-blocking assignment statements in function
  function automatic integer my_calculation_func;
    input integer func_input;
    begin
      // WRN_44: This non-blocking assignment directly to the function's return value
      // is not supported by some simulators or Verilog standards for functions.
      my_calculation_func <= func_input + 1;
    end
  endfunction

  assign out_val = my_calculation_func(in_val);

endmodule
