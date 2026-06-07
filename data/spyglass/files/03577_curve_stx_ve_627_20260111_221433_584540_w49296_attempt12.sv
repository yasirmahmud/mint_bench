module curve_stx_ve_627_20260111_221433_584540_w49296_attempt12 (
  input wire [7:0] in_a,
  input wire [7:0] in_b,
  input wire [7:0] in_c,
  output wire [7:0] out_res1,
  output wire [7:0] out_res2,
  output wire [7:0] out_res3
);

  // Function definition: expects 2 arguments (op1, op2)
  function automatic [7:0] combine_operands;
    input [7:0] op1;
    input [7:0] op2;
    begin
      combine_operands = op1 + op2;
    end
  endfunction

  // These assignments trigger STX_VE_627 violations.
  // 'combine_operands' is called with 1 argument, but expects 2.
  assign out_res1 = combine_operands(in_a); // Call 1: Too few arguments (expected 2, got 1)
  assign out_res2 = combine_operands(in_b); // Call 2: Too few arguments (expected 2, got 1)
  assign out_res3 = combine_operands(in_c); // Call 3: Too few arguments (expected 2, got 1)

endmodule
