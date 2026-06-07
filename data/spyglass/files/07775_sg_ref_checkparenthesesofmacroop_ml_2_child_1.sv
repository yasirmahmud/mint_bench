module check_macro_op_ex2;
 'define MY_MACRO (1 + 2)
 reg [3:0] a;
 assign a = MY_MACRO;
 endmodule
