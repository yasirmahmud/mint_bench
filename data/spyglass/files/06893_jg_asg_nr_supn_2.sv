module assign_to_supply1_net (
  input wire enable_signal
);
  supply1 my_vcc;
  assign my_vcc = enable_signal; // Attempting to assign to a supply1 net
endmodule
