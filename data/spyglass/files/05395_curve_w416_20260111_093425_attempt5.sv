module curve_w416_20260111_093425_attempt5;

  // Declare a function with a 2-bit return type
  function [1:0] get_truncated_value;
    // Declare an input with an 8-bit width
    input [7:0] data_in;

    // Assign the 8-bit input 'data_in' to the 2-bit function return value.
    // This triggers W416 because the assigned value's width (8) is greater
    // than the function's declared return type width (2).
    get_truncated_value = data_in;
  endfunction

endmodule
