module curve_elab_6202_20260110_160300_attempt12 ();

  genvar i;

  generate
    // ELAB_6202: Infinite for loop found in the design
    // The genvar 'i' is initialized to 0. The loop condition 'i >= 0' is
    // always true for an unsigned genvar. The update statement 'i = i' does
    // not change the value of 'i', ensuring the loop condition never becomes
    // false. This creates an infinite loop during elaboration.
    for (i = 0; i >= 0; i = i) begin : truly_infinite_gen_loop
      // A minimal statement to make the generate block syntactically valid.
      localparam DUMMY_CONSTANT = 1;
    end
  endgenerate

endmodule
