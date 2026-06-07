module pwrdn_bb_ex2 (input clk, input rst_n, input data_in, output data_out);
 wire bb_out;
 my_black_box u_bb (.out_bb(bb_out));
 my_cell u_cell (.PWRDN(bb_out), .in_a(data_in), .out_z(data_out));
 // Removed: wire _unused_clk = clk;     // Removed to resolve W528
 // Removed: wire _unused_rst_n = rst_n; // Removed to resolve W528
 endmodule
