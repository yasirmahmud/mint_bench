module curve_synth_126_20260111_022821_attempt5 (
  input            clk,
  input      [3:0] in_val,
  output reg [3:0] out_val
);

  reg [3:0] data_reg; // Declared as reg, targeted by 'assign' inside always

  // SYNTH_126: Procedural continuous assign statements are not synthesizable
  // An 'assign' statement inside an 'always' block is a procedural continuous assign.
  always @(negedge clk) begin // Using negedge for distinction from context examples
    assign data_reg = in_val; // This line triggers SYNTH_126
  end

  // Use data_reg to drive the output, ensuring all signals are used.
  always @* begin
    out_val = data_reg;
  end

endmodule
