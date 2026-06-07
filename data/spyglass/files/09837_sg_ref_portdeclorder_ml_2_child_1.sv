module port_order_ex2 (in1, in2);
  input in1;
  input in2;

  // Internal wires to prevent 'declared but not read' warnings
  // while preserving the module's input interface.
  wire dummy_in1;
  wire dummy_in2;

  assign dummy_in1 = in1;
  assign dummy_in2 = in2;

endmodule
