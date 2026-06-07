module HangingInstInput_ML_ex1 ();
 wire undriven_input_net;
 wire unused_output_net;
 my_cell u_inst (.in_port(undriven_input_net), .out_port(unused_output_net));
 endmodule
