module assign_to_supply1_net (
  input wire enable_signal
);
  wire my_vcc; // Changed from supply1 to wire to allow assignment
  assign my_vcc = enable_signal; // Now a valid assignment to a wire
endmodule
