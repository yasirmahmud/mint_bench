module top_module_ex1();
 wire [7:0] w_out_data;
 my_param_module u_param_inst (.in_data (8'hAA), .out_data (w_out_data));
 endmodule
