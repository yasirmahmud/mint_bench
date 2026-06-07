module parent_module_ex2;
 wire unused_io_net;
 assign unused_io_net = 1'b0; // Added to resolve 'undriven input terminal' violation.
 child_mod u_inst (.io(unused_io_net));
 endmodule
