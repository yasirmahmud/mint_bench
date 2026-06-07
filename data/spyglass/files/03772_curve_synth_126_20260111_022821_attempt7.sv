module curve_synth_126_20260111_022821_attempt7 (
  input      [7:0] in_data,
  output reg [7:0] out_data
);

  reg [7:0] my_internal_reg; // This 'reg' will be driven by the procedural continuous assign

  // SYNTH_126: Procedural continuous assign statements are not synthesizable
  // An 'assign' statement placed inside a procedural block (like 'always') is
  // considered a procedural continuous assign, which is non-synthesizable.
  always @* begin
    assign my_internal_reg = in_data; // This line triggers SYNTH_126
  end

  // Drive an output using the internal register to ensure all signals are used.
  always @* begin
    out_data = my_internal_reg;
  end

endmodule
