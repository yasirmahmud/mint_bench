module sub_module (input in_port, output dummy_out);
  // Fix: Add internal logic to use in_port and make the module non-empty
  //      The internal_dummy_wire is no longer needed as in_port drives an output directly.
  assign dummy_out = in_port;
 endmodule
