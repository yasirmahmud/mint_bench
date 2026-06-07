module curve_elab_6202_20260110_160300_attempt8 ();

  genvar i;

  generate
    // ELAB_6202: Infinite for loop found in the design
    // This loop is infinite because 'i' starts at 0, is decremented, and will
    // always remain less than 10 (as 'i' is a signed genvar).
    for (i = 0; i < 10; i = i - 1) begin : infinite_gen_loop
      // A minimal statement to make the generate block syntactically valid.
      // This localparam declaration will cause infinite elaboration attempts.
      localparam [7:0] LP_VAL = i;
    end
  endgenerate

endmodule
