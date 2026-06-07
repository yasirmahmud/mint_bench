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
    // These calls triggered STX_VE_627 because 'calculate_sum' is defined
    // to expect 3 arguments (val1, val2, val3) but received only 2 arguments.
    // The violation is resolved by adding a third argument (8'd0) to each call
    // to preserve the sum of the first two explicitly provided values.
    sum_out1 = calculate_sum(8'd10, 8'd20, 8'd0); // Call 1: Resolved
    sum_out2 = calculate_sum(8'd30, 8'd40, 8'd0); // Call 2: Resolved
    sum_out3 = calculate_sum(8'd50, 8'd60, 8'd0); // Call 3: Resolved
  end

endmodule
