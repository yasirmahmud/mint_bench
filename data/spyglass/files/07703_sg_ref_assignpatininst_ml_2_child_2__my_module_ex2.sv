module my_module_ex2;
 wire [7:0] local_p_data [0:1];
 assign local_p_data[0] = 8'h11;
 assign local_p_data[1] = 8'h22;
 child_mod inst_child (.p_data (local_p_data));
 endmodule
