module top_module_ex1;
 reg r_data;
 wire w_result;
 sub_module u_inst (.i_a(r_data & 1'b1), .o_b(w_result));
 endmodule
