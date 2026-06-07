module curve_w416_20260111_201205_450465_w36056_attempt8;

  // This function declares a return type width of 2 bits.
  function [1:0] get_truncated_value;
    // The input to the function is 8 bits wide.
    input [7:0] data_in;
    
    // W416 violation: The return type width (2 bits for 'get_truncated_value')
    // is less than the width of the value being assigned (8 bits for 'data_in').
    get_truncated_value = data_in;
  endfunction

  // Minimal instantiation to ensure the function is used and prevent unused signal warnings.
  // Changed from 'wire' to 'reg' in this attempt to fix STX_VE_361 from the previous attempt.
  reg [1:0] result_from_func;
  reg [7:0] input_to_func;

  initial begin
    input_to_func = 8'hFF; // Assign an arbitrary value to the input.
    result_from_func = get_truncated_value(input_to_func);
    #1; // Advance simulation time slightly
  end

endmodule
