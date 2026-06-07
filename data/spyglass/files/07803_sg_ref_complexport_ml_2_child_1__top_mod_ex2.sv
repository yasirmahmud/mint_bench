module top_mod_ex2;
 wire [15:0] w_data;
 assign w_data = 16'h1234;
 sub_mod_for_ex2 inst_sub (.p_in(w_data[7:0]));
 endmodule
