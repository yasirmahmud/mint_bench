module top_ex2;
 wire my_reg; // Changed from 'reg' to 'wire' to resolve port type mismatch
 wire my_reg_read_dummy; // Added to ensure 'my_reg' is read, resolving W528
 sub_ex2 u_sub_ex2 (.data_out(my_reg));
 assign my_reg_read_dummy = my_reg; // Reading 'my_reg'
 endmodule
