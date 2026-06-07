module curve_stx_ve_627_20260112_005652_552091_w37744_attempt13 (
  input [7:0] in_val1,
  input [7:0] in_val2,
  input [7:0] in_val3,
  input [7:0] in_val4,
  output [7:0] out_res1,
  output [7:0] out_res2,
  output [7:0] out_res3
);

  // Define a function that expects 4 arguments
  function automatic [7:0] compute_complex;
    input [7:0] op1;
    input [7:0] op2;
    input [7:0] op3;
    input [7:0] op4;
    begin
      // Perform a simple operation using all arguments to ensure they are 'used'
      compute_complex = op1 + op2 - op3 + op4;
    end
  endfunction

  // These assignments will trigger STX_VE_627 violations because 'compute_complex'
  // is defined to expect 4 arguments (op1, op2, op3, op4), but each call provides only 3.
  assign out_res1 = compute_complex(in_val1, in_val2, in_val3); // Call 1: Too few arguments (expected 4, got 3)
  assign out_res2 = compute_complex(in_val2, in_val3, in_val4); // Call 2: Too few arguments (expected 4, got 3)
  assign out_res3 = compute_complex(in_val3, in_val4, in_val1); // Call 3: Too few arguments (expected 4, got 3)

endmodule
