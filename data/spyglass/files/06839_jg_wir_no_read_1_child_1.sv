module unread_wire_example1 (
  input clk,
  input rst
);

  // wire unused_signal; // Removed as it was assigned but never read, causing a WIR_NO_READ violation.

  // assign unused_signal = clk & rst; // Removed as the signal is no longer needed.

endmodule
