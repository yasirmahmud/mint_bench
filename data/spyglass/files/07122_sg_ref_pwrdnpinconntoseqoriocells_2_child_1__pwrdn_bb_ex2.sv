module pwrdn_bb_ex2 (input clk, input rst_n, input data_in, output data_out);
 wire bb_out;
 my_black_box u_bb (.out_bb(bb_out));
 my_cell u_cell (.PWRDN(bb_out), .in_a(data_in), .out_z(data_out));
 wire _unused_clk = clk;     // Added to resolve W240: Input 'clk' declared but not read.
 wire _unused_rst_n = rst_n; // Added to resolve W240: Input 'rst_n' declared but not read.
 endmodule
