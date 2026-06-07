module top_module_ex2;
 reg a;
 child_mod u_inst (.i (~a));
 initial a = 1'b0;
 endmodule
