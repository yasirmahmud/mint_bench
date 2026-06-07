module partial_constant_assign_ex2(input sel, output reg out_sig);
 always @(*) if(sel) out_sig = 1'b1;
 endmodule
