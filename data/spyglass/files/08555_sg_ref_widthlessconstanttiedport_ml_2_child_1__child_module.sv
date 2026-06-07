module child_module (input [0:0] in_port);
  // To resolve 'empty definition' and 'input not read' violations,
  // and to explicitly define the width as implied by the constant '0',
  // a dummy wire is added to consume the input.
  wire dummy_signal_to_consume_input = in_port;
endmodule
