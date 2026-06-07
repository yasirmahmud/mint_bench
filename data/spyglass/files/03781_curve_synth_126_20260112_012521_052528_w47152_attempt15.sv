module curve_synth_126_20260112_012521_052528_w47152_attempt15 (
    input clk,
    input reset_n,
    input [7:0] data_in,
    output [7:0] data_out
);

  // Declare a wire that will be driven by a procedural continuous assign.
  // Wires are typically driven by non-procedural 'assign' statements or module outputs.
  wire [7:0] internal_result_wire;

  // This 'always' block defines sequential logic for a clocked process.
  // An 'assign' statement, which is a continuous assignment, is placed inside it.
  // This combination is known as a procedural continuous assign.
  always @(posedge clk or negedge reset_n) begin
    // This 'assign' statement inside a procedural block (always) is not synthesizable
    // and directly triggers the SYNTH_126 violation (Procedural continuous assign statements are not synthesizable).
    assign internal_result_wire = data_in; // This line triggers SYNTH_126
  end

  // Connect the procedurally assigned wire to the output to ensure it's used
  // and avoid unused signal warnings/violations.
  assign data_out = internal_result_wire;

endmodule
