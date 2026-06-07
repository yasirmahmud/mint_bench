module curve_synth_126_20260111_022821_attempt6 (
  input      [1:0] in_sig,
  output reg [1:0] out_sig
);

  reg [1:0] internal_reg; // Target for the procedural continuous assign

  // SYNTH_126: Procedural continuous assign statements are not synthesizable
  // An 'assign' statement inside an 'initial' block is a procedural continuous assign.
  // This construct is explicitly non-synthesizable for functional logic.
  initial begin
    assign internal_reg = in_sig; // This line triggers SYNTH_126
  end

  // Drive output using the affected signal to ensure all signals are used
  always @* begin
    out_sig = internal_reg;
  end

endmodule
