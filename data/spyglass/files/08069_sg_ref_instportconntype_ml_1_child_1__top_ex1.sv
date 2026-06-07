module top_ex1;
 wire my_reg; // Changed from 'reg' to 'wire' to correctly connect to an output port
 sub_module u_inst (.out_port(my_reg));
 endmodule
