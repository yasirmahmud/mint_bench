module multi_assign_concat_ex2;
 wire [0:0] a;
 wire [1:0] b;
 assign {a, a} = b;
 endmodule
