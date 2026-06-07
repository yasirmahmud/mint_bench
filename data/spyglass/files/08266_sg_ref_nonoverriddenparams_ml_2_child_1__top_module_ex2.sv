module top_module_ex2;
 wire [7:0] d_in;
 wire [7:0] d_out;
 child_module_ex2 u_inst (.in_data(d_in), .out_data(d_out));
 endmodule
