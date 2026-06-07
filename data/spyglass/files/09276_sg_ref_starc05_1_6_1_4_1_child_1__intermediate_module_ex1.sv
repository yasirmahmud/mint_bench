module intermediate_module_ex1 (input i_clk, input i_rst_n, output int_clk);
 clockgenmodule cg_inst (.i_clk(i_clk), .i_rst_n(i_rst_n), .clk_out(int_clk));
endmodule
