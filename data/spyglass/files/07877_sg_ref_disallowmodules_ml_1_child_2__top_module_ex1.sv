module top_module_ex1;
  // Wires for connecting to the disallowed module's dummy ports
  wire u_disallowed_dummy_in;
  wire u_disallowed_dummy_out;

  disallowed_sub_ex1 u_disallowed_inst (
    .dummy_in  (u_disallowed_dummy_in),
    .dummy_out (u_disallowed_dummy_out)
  );
endmodule
