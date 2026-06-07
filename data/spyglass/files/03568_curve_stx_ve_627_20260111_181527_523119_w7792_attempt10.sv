module curve_stx_ve_627_20260111_181527_523119_w7792_attempt10 (
  output reg [7:0] sum_out1,
  output reg [7:0] sum_out2,
  output reg [7:0] sum_out3
);

  // Define a function that expects 3 arguments
  function automatic [7:0] calculate_sum;
    input [7:0] val1;
    input [7:0] val2;
    input [7:0] val3;
    calculate_sum = val1 + val2 + val3;
  endfunction

  initial begin
    // These calls trigger STX_VE_627 because 'calculate_sum' is defined
    // to expect 3 arguments (val1, val2, val3) but receives only 2 arguments.
    sum_out1 = calculate_sum(8'd10, 8'd20); // Call 1: Too few arguments (expected 3, got 2)
    sum_out2 = calculate_sum(8'd30, 8'd40); // Call 2: Too few arguments (expected 3, got 2)
    sum_out3 = calculate_sum(8'd50, 8'd60); // Call 3: Too few arguments (expected 3, got 2)
  end

endmodule
