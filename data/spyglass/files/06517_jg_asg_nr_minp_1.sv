module BadInputAssign1 (
  input wire in_port_a,
  output wire out_port_b
);

  assign in_port_a = 1'b1; // Illegal: Assigning to an input port

  assign out_port_b = in_port_a;

endmodule
