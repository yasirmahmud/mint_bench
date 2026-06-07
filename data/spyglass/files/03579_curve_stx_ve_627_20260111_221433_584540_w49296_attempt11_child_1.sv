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

  // These assignments triggered STX_VE_627 violations due to too few arguments.
  // The violations are resolved by providing a third argument (0) to each call.
  // This maintains the spirit of the 'val1 * val2 + val3' calculation, effectively making 'val3' zero for these calls.
  assign out_prod1 = calculate_product(in_a, in_b, 8'd0);
  assign out_prod2 = calculate_product(in_b, in_c, 8'd0);
  assign out_prod3 = calculate_product(in_c, in_a, 8'd0);

endmodule
