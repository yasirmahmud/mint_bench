module top_module_ex2 ();
 wire undriven_signal;
 wire dummy_out;
 sub_module_ex2 inst_ex2 (.in_port(undriven_signal), .out_port(dummy_out));
 endmodule
