module curve_elab_6202_20260110_160300_attempt10 ();

  genvar i;

  generate
    // ELAB_6202: Infinite for loop found in the design
    // The genvar 'i' is initialized to 0. The loop condition 'i < 10' is
    // always true because the update statement 'i = i + 0' ensures that 'i'
    // never changes from its initial value of 0. This creates an infinite
    // loop during elaboration, triggering ELAB_6202.
    for (i = 0; i < 10; i = i + 0) begin : infinite_gen_loop
      // A minimal statement to make the generate block syntactically valid.
      localparam [7:0] DUMMY_VAL = 8'd0;
    end
  endgenerate

endmodule
