module pwrdn_bb_ex2 (input clk, input rst_n, input data_in, output data_out);
 wire bb_out;
 my_black_box u_bb (.out_bb(bb_out));
 my_cell u_cell (.PWRDN(bb_out), .in_a(data_in), .out_z(data_out));
 endmodule
