module curve_stx_ve_627_20260111_181527_523119_w7792_attempt8 (
  output reg [7:0] result_out
);

  // Define a function that expects 3 arguments
  function automatic [7:0] calculate_sum;
    input [7:0] a;
    input [7:0] b;
    input [7:0] c;
    calculate_sum = a + b + c;
  endfunction

  initial begin
    // This call originally triggered STX_VE_627 due to too few arguments.
    // Fixed by providing default arguments (0, 0) for b and c, maintaining 'a' as 5.
    result_out = calculate_sum(5, 0, 0);
  end

endmodule
