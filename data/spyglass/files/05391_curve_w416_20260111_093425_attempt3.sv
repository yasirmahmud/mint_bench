module curve_w416_20260111_093425_attempt3;

  // Declare a function with a 4-bit return type
  function [3:0] calculate_mismatched_result;
    // Declare an input with a 16-bit width
    input [15:0] large_value_in;

    // Assign the 16-bit input to the 4-bit function return value.
    // This triggers W416 because the assigned value's width (16)
    // is greater than the function's declared return type width (4).
    calculate_mismatched_result = large_value_in;
  endfunction

endmodule
