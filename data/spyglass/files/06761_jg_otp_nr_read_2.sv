module example_2 (
  input wire in_val,
  output wire out_val
);

  wire internal_signal;

  // out_val is read here by being assigned to an internal signal
  assign internal_signal = out_val;

  // out_val is driven here
  assign out_val = in_val;

endmodule
