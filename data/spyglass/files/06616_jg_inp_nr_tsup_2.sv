module tie_input_to_supply1 (
  input wire control_in,
  output wire status_out
);
  assign control_in = supply1; // Input tied to supply1
  assign status_out = control_in;
endmodule
