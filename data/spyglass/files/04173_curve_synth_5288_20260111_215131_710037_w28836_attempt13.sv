module synth_5288_attempt_13 ();

  // Declare an event data type. Usage of 'event' is a Verilog feature
  // not synthesizable by RTL synthesis tools.
  event synth_violation_event;

  // Declare a register without an initial assignment at declaration
  // to avoid a SYNTH_89 warning (Initial Assignment at Declaration is ignored).
  reg dummy_output_reg;

  // This always block is sensitive to the 'synth_violation_event'.
  // The sensitivity to an 'event' type directly triggers the SYNTH_5288 violation.
  // This entire block is unsynthesizable.
  always @(synth_violation_event) begin
    // This assignment provides activity for 'dummy_output_reg', ensuring it is used
    // and avoiding potential unused signal warnings, even though the block itself
    // is unsynthesizable due to the 'event' sensitivity.
    dummy_output_reg <= 1'b0;
  end

endmodule
