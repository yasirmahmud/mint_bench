module hanging_inst_input_ex2 (output out_top);
 wire undriven_net;
 my_cell u_inst (.in_port(undriven_net), .out_port(out_top));
 endmodule
