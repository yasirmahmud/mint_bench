module curve_w416_20260111_093425_attempt6;

  // Declare a function with a 3-bit return type
  function [2:0] calculate_value;
    // Declare an input with a 5-bit width
    input [4:0] data_in;

    // Assign the 5-bit input 'data_in' to the 3-bit function return value.
    // This triggers W416 because the assigned value's width (5) is greater
    // than the function's declared return type width (3).
    calculate_value = data_in;
  endfunction

endmodule
