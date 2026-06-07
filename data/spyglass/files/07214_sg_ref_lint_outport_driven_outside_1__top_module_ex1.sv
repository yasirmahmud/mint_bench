module top_module_ex1;
 wire w_out;
 sub_module_ex1 u_sub (.out_p(w_out));
 assign w_out = 1'b0;
 endmodule
