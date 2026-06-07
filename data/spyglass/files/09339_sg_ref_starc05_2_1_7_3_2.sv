module star_c05_2_1_7_3_ex2(input in_val, output [3:0] my_vec_ex2);
 assign my_vec_ex2 = '{2: in_val, default: 1'b0};
 endmodule
