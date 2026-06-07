module curve_synth_5064_20260111_091216_attempt8 (
  input wire a,
  input wire b,
  output reg out
);

  // This always_comb block implements simple synthesizable combinational logic.
  always @* begin
    out = a && b; // Standard synthesizable logic

    // SYNTH_5064: An immediate 'cover' statement (a SystemVerilog construct)
    // is not synthesizable and will be ignored by synthesis tools.
    // This triggers the SYNTH_5064 violation.
    cover (a && b); // Immediate cover statement
  end

endmodule
