module HangingInstInput_ML_ex1 ();
 wire undriven_input_net;
 assign undriven_input_net = 1'b0;
 wire unused_out_port;
 my_cell u_inst (.in_port(undriven_input_net), .out_port(unused_out_port));
 endmodule
