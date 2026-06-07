module curve_w416_20260111_201205_450465_w36056_attempt10;

  // This function declares a return type width of 1 bit.
  function [0:0] calculate_result;
    // The input to the function is 4 bits wide.
    input [3:0] wide_signal;

    // W416 violation: The return type width (1 bit for 'calculate_result')
    // is less than the width of the value being assigned (4 bits for 'wide_signal').
    calculate_result = wide_signal;
  endfunction

endmodule
