module curve_synth_126_20260111_184224_680196_w37940_attempt9 (
  input clk,
  input in_data,
  output reg out_data
);

  reg temp_reg;

  // SYNTH_126: Procedural continuous assign statements are not synthesizable.
  // An 'assign' statement within an 'always' block is a procedural continuous assign.
  always @(posedge clk) begin
    // This 'assign' statement inside an 'always @(posedge clk)' block triggers SYNTH_126.
    assign temp_reg = in_data;
    
    // This is a valid sequential assignment and does not trigger other rules.
    out_data <= temp_reg;
  end

endmodule
