module curve_elab_6202_20260111_235143_208492_w6680_attempt22();

  generate
    genvar i; // Declare genvar for Verilog-2001 compatibility
    // This generate for loop creates an infinite elaboration loop.
    // The loop variable 'i' starts at 10.
    // The condition 'i <= 10' is initially true.
    // The step 'i = i' ensures 'i' never changes, keeping the condition always true.
    // This static nature of the loop variable should make it easily detectable as
    // an infinite loop during elaboration, triggering ELAB_6202.
    for (i = 10; i <= 10; i = i) begin : infinite_static_value_loop
      // A minimal localparam declaration to make the generate block syntactically valid.
      // This avoids warnings about empty generate blocks and does not create unused signals or latches.
      localparam [0:0] DUMMY_BIT = 1'b0;
    end
  endgenerate

endmodule
