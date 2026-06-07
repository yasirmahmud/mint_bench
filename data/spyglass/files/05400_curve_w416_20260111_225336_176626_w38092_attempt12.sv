module curve_w416_20260111_225336_176626_w38092_attempt12 (
  input wire [8:0] input_data_wide, // A wide input signal
  output wire [3:0] truncated_result // A narrower output for the truncated result
);

  // Function 'calculate_sum' is declared to return a 4-bit value ([3:0]).
  function [3:0] calculate_sum;
    input [8:0] operand_a; // Input to the function is 9 bits wide.
    
    // Declare a local register within the function to hold the intermediate value.
    // Its width matches 'operand_a'.
    reg [8:0] temp_val;
    
    begin
      // Assign the function input to the local register.
      // This assignment has matching widths (9 bits to 9 bits).
      temp_val = operand_a;
      
      // W416 violation:
      // The function's declared return type width (4 bits for 'calculate_sum')
      // is less than the width of the value being assigned (9 bits from 'temp_val').
      calculate_sum = temp_val;
    end
  endfunction

  // Instantiate the function and connect its result to the module output.
  // This ensures all signals are used and avoids unused signal warnings.
  assign truncated_result = calculate_sum(input_data_wide);

endmodule
