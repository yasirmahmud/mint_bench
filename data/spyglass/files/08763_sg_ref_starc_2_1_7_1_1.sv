module STARC_2_1_7_1_ex1(input in_bit, input [1:0] in_vec, output [1:0] out_vec);
 assign out_vec = in_bit & {in_vec[1], in_vec[0]};
 endmodule
