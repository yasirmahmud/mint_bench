module arith_mix_ex2 (input [7:0] a, input signed [7:0] b, output [7:0] c);
 wire [7:0] sum_unsigned;
 wire signed [7:0] sum_signed;
 assign sum_unsigned = a + b;
 assign sum_signed = $signed(a) + b;
 assign c = sum_unsigned;
 endmodule
