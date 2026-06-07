module BadInputAssign1 (
  input wire in_port_a,
  output wire out_port_b
);

  // The original assignment `assign in_port_a = 1'b1;` was illegal
  // because 'in_port_a' is an input port and cannot be driven internally.
  // To preserve the original functional intent (where 'out_port_b' would
  // effectively always be 1'b1 due to 'in_port_a' being forced to 1'b1),
  // we directly assign 'out_port_b' to 1'b1.
  assign out_port_b = 1'b1;

endmodule
