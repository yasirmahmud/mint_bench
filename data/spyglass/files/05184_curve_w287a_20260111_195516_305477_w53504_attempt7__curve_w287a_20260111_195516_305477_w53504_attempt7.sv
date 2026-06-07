module curve_w287a_20260111_195516_305477_w53504_attempt7 (
  input  top_input,
  output top_output
);

  // Declare a wire that is never driven by any source.
  wire undriven_control_signal;

  // Instantiate the sub-module. One input is connected to the undriven wire.
  my_component u_sub (
    .data_in_a(undriven_control_signal), // This input is connected to an undriven wire, triggering W287a.
    .data_in_b(top_input),
    .result_out(top_output)
  );

endmodule
