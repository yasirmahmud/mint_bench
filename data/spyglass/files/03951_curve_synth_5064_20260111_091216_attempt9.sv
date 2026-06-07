module curve_synth_5064_20260111_091216_attempt9 (
  input wire a,
  output reg out
);

  // This always_comb block contains synthesizable logic.
  always @* begin
    out = a; // Simple synthesizable assignment

    // SYNTH_5064: An immediate 'assert' statement (a SystemVerilog construct)
    // is not synthesizable and will be ignored by synthesis tools.
    // This is expected to trigger the SYNTH_5064 violation.
    assert (1'b1);
  end

endmodule
