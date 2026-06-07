module starc_1_1_1_5_ex1 (input my_signal);
 // The wire 'my_signal_int' and its assignment have been removed
 // as it was set but never read, resolving the W528 violation.
 // This maintains the original functional behavior as the wire
 // was not used for any other logic or output.
 endmodule
