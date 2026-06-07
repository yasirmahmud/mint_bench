module top_module_ex1;
 wire [7:0] my_wire;
 assign my_wire = 8'hFF;
 sub_module u_sub ( .in_port(my_wire) );
endmodule
