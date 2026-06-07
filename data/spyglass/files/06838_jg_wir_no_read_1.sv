module unread_wire_example1 (
  input clk,
  input rst
);

  wire unused_signal;

  assign unused_signal = clk & rst;

endmodule
