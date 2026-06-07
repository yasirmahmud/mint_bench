module top_module_ex2;
 wire [7:0] my_wire;
 wire [7:0] dummy_sub_out;

 assign my_wire = 8'h00;

 sub_module_ex2 inst_sub_ex2 (.data_port(my_wire), .dummy_out(dummy_sub_out));
 endmodule
