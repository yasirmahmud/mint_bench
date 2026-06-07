module top_ex1 (input clk_i);
 wire q_data;
 master_mod u_master (.i_clk (clk_i), .o_data(q_data));
 endmodule
