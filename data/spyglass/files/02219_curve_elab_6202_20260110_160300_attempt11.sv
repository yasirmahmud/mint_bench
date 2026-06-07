module curve_elab_6202_20260110_160300_attempt11 ();

  genvar i;

  generate
    // ELAB_6202: Infinite for loop found in the design
    // The genvar 'i' is initialized to 0. The loop condition 'i >= 0' is
    // always true for a non-negative genvar. The update statement 'i = i + 1'
    // increments 'i', but the condition 'i >= 0' will never become false.
    // This creates an infinite loop during elaboration, triggering ELAB_6202.
    for (i = 0; i >= 0; i = i + 1) begin : truly_infinite_gen_loop
      // A minimal statement to make the generate block syntactically valid.
      localparam [7:0] DUMMY_CONSTANT = 8'd0;
    end
  endgenerate

endmodule
