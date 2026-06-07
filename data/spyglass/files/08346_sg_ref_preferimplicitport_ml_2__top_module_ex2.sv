module top_module_ex2;
 wire data_in;
 wire data_out;
 child_module u_inst (.data_in(data_in), .data_out(data_out));
 endmodule
