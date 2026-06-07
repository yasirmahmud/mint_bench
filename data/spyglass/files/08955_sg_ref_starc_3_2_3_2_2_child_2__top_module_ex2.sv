module top_module_ex2 (input [2:0] a);
 wire [4:0] unused_out1;
 sub_module_ex2 inst_ex2 (.in1({2'b0, a}), .out1(unused_out1));
 endmodule
