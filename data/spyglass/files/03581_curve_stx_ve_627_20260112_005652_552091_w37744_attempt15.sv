module curve_stx_ve_627_20260112_005652_552091_w37744_attempt15 (
  input [7:0] val_x,
  input [7:0] val_y,
  input [7:0] val_z,
  output [7:0] out_a,
  output [7:0] out_b,
  output [7:0] out_c
);

  // Define a function that expects 3 arguments
  function automatic [7:0] compute_sum_and_divide;
    input [7:0] arg1;
    input [7:0] arg2;
    input [7:0] arg3;
    begin
      // Use all arguments to avoid unused signal warnings within the function
      compute_sum_and_divide = (arg1 + arg2 + arg3) / 3;
    end
  endfunction

  // These assignments will trigger STX_VE_627 violations because 'compute_sum_and_divide'
  // is defined to expect 3 arguments, but each call provides only 2.
  assign out_a = compute_sum_and_divide(val_x, val_y); // Call 1: Too few arguments (expected 3, got 2)
  assign out_b = compute_sum_and_divide(val_y, val_z); // Call 2: Too few arguments (expected 3, got 2)
  assign out_c = compute_sum_and_divide(val_z, val_x); // Call 3: Too few arguments (expected 3, got 2)

endmodule
