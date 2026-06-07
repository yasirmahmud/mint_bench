module top_module_ex2;
wire regular_driver_sig;
child_module u_child (.out_port(regular_driver_sig));

// Added to resolve "Variable 'regular_driver_sig' set but not read" warning (W528)
wire dummy_read_of_regular_driver_sig;
assign dummy_read_of_regular_driver_sig = regular_driver_sig;

endmodule
