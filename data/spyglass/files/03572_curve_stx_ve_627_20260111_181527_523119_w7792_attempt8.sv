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
    // This call triggers STX_VE_627:
    // 'calculate_sum' is defined to expect 3 arguments (a, b, c)
    // It is called with only 1 argument (the literal '5'), resulting in too few arguments.
    result_out = calculate_sum(5);
  end

endmodule
