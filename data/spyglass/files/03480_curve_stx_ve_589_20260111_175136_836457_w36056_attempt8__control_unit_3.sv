module control_unit (
  input wire start_signal,
  output wire done_signal
);
  assign done_signal = start_signal;
endmodule
