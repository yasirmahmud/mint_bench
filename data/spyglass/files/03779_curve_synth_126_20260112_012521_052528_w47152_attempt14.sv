module curve_synth_126_20260112_012521_052528_w47152_attempt14 (
    input [3:0] in_data,
    output [3:0] out_data
);

  // Declare a wire that will be driven by a procedural continuous assign.
  wire [3:0] internal_wire;

  // This 'always @*' block contains a procedural continuous assign statement.
  // An 'assign' statement inside an 'always' or 'initial' block is not synthesizable
  // and directly triggers the SYNTH_126 violation.
  always @* begin
    // This line triggers SYNTH_126
    assign internal_wire = in_data;
  end

  // Connect the procedurally assigned wire to the output to ensure it's used.
  assign out_data = internal_wire;

endmodule
