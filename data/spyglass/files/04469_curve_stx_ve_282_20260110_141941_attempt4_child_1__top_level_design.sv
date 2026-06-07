module top_level_design (
  input top_in_1,
  input top_in_2,
  output top_out_1,
  output top_out_2
);

  // Instance of my_sub_module with two non-existent port connections
  my_sub_module u_instance (
    .sub_in_a(top_in_1),
    .sub_out_b(top_out_1)
  );

endmodule
