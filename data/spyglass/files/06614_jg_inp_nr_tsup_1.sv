module tie_input_to_supply0 (
  input wire my_signal_in,
  output wire my_signal_out
);
  assign my_signal_in = supply0; // Input tied to supply0
  assign my_signal_out = my_signal_in;
endmodule
