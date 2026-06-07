module curve_w416_20260111_093425_attempt2;

  // Function with a declared return type width of 2 bits
  function [1:0] get_truncated_value;
    // Input with a width of 8 bits
    input [7:0] data_in;

    // Assigning the 8-bit input to the 2-bit function return value.
    // This triggers W416 as the return type width (2) is less than
    // the assigned return value width (8).
    get_truncated_value = data_in;
  endfunction

endmodule
