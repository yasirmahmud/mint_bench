module curve_stx_ve_627_20260111_221433_584540_w49296_attempt11 (
  input wire [7:0] in_a,
  input wire [7:0] in_b,
  input wire [7:0] in_c,
  output wire [15:0] out_prod1,
  output wire [15:0] out_prod2,
  output wire [15:0] out_prod3
);

  // Function definition: expects 3 arguments (val1, val2, val3)
  function automatic [15:0] calculate_product;
    input [7:0] val1;
    input [7:0] val2;
    input [7:0] val3;
    begin
      calculate_product = val1 * val2 + val3;
    end
  endfunction

  // These assignments trigger STX_VE_627 violations.
  // 'calculate_product' is called with 2 arguments, but expects 3.
  assign out_prod1 = calculate_product(in_a, in_b); // Call 1: Too few arguments
  assign out_prod2 = calculate_product(in_b, in_c); // Call 2: Too few arguments
  assign out_prod3 = calculate_product(in_c, in_a); // Call 3: Too few arguments

endmodule
