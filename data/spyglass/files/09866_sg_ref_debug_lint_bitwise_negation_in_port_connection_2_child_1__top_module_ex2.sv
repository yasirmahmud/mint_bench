module top_module_ex2;
 wire a;
 assign a = 1'b0;
 child_mod u_inst (.i (~a));
 endmodule
