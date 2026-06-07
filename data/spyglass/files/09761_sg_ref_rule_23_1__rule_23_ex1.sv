module rule_23_ex1 (input clk_i, input d_i, output q_o);
 wire gnd = 1'b0;
 my_dff i_dff (.D(d_i), .CLK(clk_i), .RST_N(gnd), .Q(q_o));
 endmodule
