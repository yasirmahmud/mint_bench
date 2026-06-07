module curve_w287a_20260111_195516_305477_w53504_attempt10 (
  output top_out
);
  wire undriven_connection_point; // Explicitly declared wire

  // Instantiate the sub-module. Its input 'sub_in' is connected to 'undriven_connection_point'.
  // Since 'undriven_connection_point' is never assigned a value, it remains undriven.
  sub_module u_instance (
    .sub_in(undriven_connection_point), // This is the input terminal that will be undriven.
    .sub_out(top_out)
  );

  // No assignment for 'undriven_connection_point' exists in this module,
  // leading to the W287a violation for u_instance.sub_in.

endmodule
