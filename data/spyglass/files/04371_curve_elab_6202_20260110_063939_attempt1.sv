module curve_elab_6202_20260110_063939_attempt1 (
  output wire dummy_out
);

  genvar i;

  generate
    // ELAB_6202: The loop condition 'i < 10' will always be true because 'i' never increments
    // (i = i). This creates an infinite loop during elaboration.
    for (i = 0; i < 10; i = i) begin : infinite_gen_loop
      // A dummy assignment to ensure the generate block is not empty.
      // SpyGlass should detect the infinite loop before attempting to
      // elaborate this assignment an infinite number of times, thus
      // avoiding secondary violations like 'multiple drivers'.
      assign dummy_out = 1'b0;
    end
  endgenerate

endmodule
