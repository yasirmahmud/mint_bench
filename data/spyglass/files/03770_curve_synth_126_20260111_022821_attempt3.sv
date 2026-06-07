module curve_synth_126_20260111_022821_attempt3 (
  input  in_data,
  output reg out_q
);

  wire intermediate_sig; // Target for procedural continuous assign

  // SYNTH_126: Procedural continuous assign statement is not synthesizable
  // The 'assign' statement is inside a procedural 'always' block.
  always @(in_data) begin
    assign intermediate_sig = in_data; // This line triggers SYNTH_126
  end

  // Standard continuous assign to connect the intermediate signal to the output
  assign out_q = intermediate_sig;

endmodule
