module top_ex1 (input clk_i);
 wire unused_o_data;
 master_mod u_master (.i_clk (clk_i), .o_data (unused_o_data));
 endmodule
