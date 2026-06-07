module curve_stx_ve_627_20260112_005652_552091_w37744_attempt16 (
  input [7:0] in_a,
  input [7:0] in_b,
  input [7:0] in_c,
  input [7:0] in_d,
  output reg [7:0] avg_out1,
  output reg [7:0] avg_out2,
  output reg [7:0] avg_out3
);

  // Define a function that expects 4 arguments
  function automatic [7:0] calculate_average;
    input [7:0] p1;
    input [7:0] p2;
    input [7:0] p3;
    input [7:0] p4;
    begin
      // Use all arguments to avoid unused signal warnings within the function
      calculate_average = (p1 + p2 + p3 + p4) / 4;
    end
  endfunction

  // These assignments will trigger STX_VE_627 violations because 'calculate_average'
  // is defined to expect 4 arguments, but each call provides only 3.
  always @* begin
    avg_out1 = calculate_average(in_a, in_b, in_c); // Call 1: Too few arguments (expected 4, got 3)
    avg_out2 = calculate_average(in_b, in_c, in_d); // Call 2: Too few arguments (expected 4, got 3)
    avg_out3 = calculate_average(in_c, in_d, in_a); // Call 3: Too few arguments (expected 4, got 3)
  end

endmodule
