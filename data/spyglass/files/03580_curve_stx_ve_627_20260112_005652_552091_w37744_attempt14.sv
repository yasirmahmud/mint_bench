module curve_stx_ve_627_20260112_005652_552091_w37744_attempt14 (
  input [7:0] data_in1,
  input [7:0] data_in2,
  input [7:0] data_in3,
  output [7:0] result_out1,
  output [7:0] result_out2,
  output [7:0] result_out3
);

  // Define a function that expects 2 arguments
  function automatic [7:0] calculate_difference;
    input [7:0] val_a;
    input [7:0] val_b;
    begin
      // Use both arguments to avoid unused signal warnings within the function
      calculate_difference = val_a - val_b;
    end
  endfunction

  // These assignments will trigger STX_VE_627 violations because 'calculate_difference'
  // is defined to expect 2 arguments (val_a, val_b), but each call provides only 1.
  assign result_out1 = calculate_difference(data_in1); // Call 1: Too few arguments (expected 2, got 1)
  assign result_out2 = calculate_difference(data_in2); // Call 2: Too few arguments (expected 2, got 1)
  assign result_out3 = calculate_difference(data_in3); // Call 3: Too few arguments (expected 2, got 1)

endmodule
