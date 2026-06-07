module BadInputAssign2 (
  input [3:0] data_in,
  output wire data_out
);

  assign data_in = 4'hA; // Illegal: Assigning to a multi-bit input port

  assign data_out = data_in[0];

endmodule
