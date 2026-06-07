module curve_synth_126_20260112_012521_052528_w47152_attempt16 (
    input logic_in,
    output logic_out
);

  // Declare an internal wire that will be driven by a procedural continuous assign.
  wire internal_signal_wire;

  // This 'always @*' block is typically used for combinational logic.
  // However, placing a continuous 'assign' statement inside it is considered
  // a procedural continuous assign, which is not synthesizable.
  always @* begin
    // This 'assign' statement inside a procedural block (always) is explicitly
    // a procedural continuous assign and directly triggers the SYNTH_126 violation.
    assign internal_signal_wire = logic_in; // This line triggers SYNTH_126
  end

  // Connect the internal wire to the output to ensure it is used
  // and avoid any unused signal warnings or violations.
  assign logic_out = internal_signal_wire;

endmodule
