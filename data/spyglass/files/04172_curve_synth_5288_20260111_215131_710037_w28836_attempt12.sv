module synth_5288_example_6 ();

  // Declare an event data type.
  // Usage of 'event' is a Verilog feature not synthesizable by RTL synthesis tools.
  event violation_event_6;

  // Declare a register to demonstrate activity, though this block is unsynthesizable.
  reg dummy_toggle_reg = 1'b0;

  // This always block is sensitive to the 'violation_event_6'.
  // The sensitivity to an 'event' type directly triggers the SYNTH_5288 violation.
  always @(violation_event_6) begin
    // This assignment itself is synthesizable logic, but the 'always @(event)' construct is not.
    dummy_toggle_reg <= ~dummy_toggle_reg;
  end

endmodule
