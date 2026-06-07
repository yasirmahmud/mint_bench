module curve_w287a_20260111_195516_305477_w53504_attempt6 (
  output logic_out
);

  // Declare a wire that is never driven.
  // Connecting this undriven wire to an instance input will trigger W287a.
  wire undriven_signal;

  sub_module u_sub (
    .in_port(undriven_signal), // Input 'in_port' of instance 'u_sub' is connected to 'undriven_signal'
    .out_port(logic_out)      // 'undriven_signal' is never driven by any source.
  );

endmodule
