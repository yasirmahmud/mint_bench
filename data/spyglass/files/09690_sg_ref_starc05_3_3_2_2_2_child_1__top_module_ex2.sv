module top_module_ex2 (input clk, output out_sig);
 wire bb_out;
 black_box_bb u_bb (.in1(clk), .out1(bb_out));
 assign out_sig = bb_out;
endmodule
