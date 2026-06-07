module top_module_ex2 (input this_is_a_very_long_port_name);
  // Resolve W240: Input 'this_is_a_very_long_port_name' declared but not read.
  wire dummy_read_port = this_is_a_very_long_port_name;
endmodule
