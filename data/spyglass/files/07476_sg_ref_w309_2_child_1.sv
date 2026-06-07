module W309_ex2;
  // my_reg was initialized to 8'hFF in the initial block and never changed.
  // To resolve SYNTH_5143 (initial block ignored for synthesis) and preserve
  // this constant value, my_reg is now declared as a wire with a continuous assignment.
  wire [7:0] my_reg = 8'hFF;

  // my_int was set but never read (W528 violation) and was only used within
  // the non-synthesizable initial block. It has been removed.

endmodule
