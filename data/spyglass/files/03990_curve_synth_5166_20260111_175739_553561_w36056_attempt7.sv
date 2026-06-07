module curve_synth_5166_20260111_175739_553561_w36056_attempt7 (
  input wire [7:0] data_in,
  input wire       enable
);

  // This $display statement is non-synthesizable and will trigger SYNTH_5166
  // Placing it in an always block rather than an initial block to avoid SYNTH_5143.
  always @(posedge enable) begin
    $display("INFO: Enable toggled. Data_in value: %h", data_in); // First occurrence
  end

  // Another non-synthesizable $display to meet the requirement of 2 occurrences.
  always @(*) begin
    // This block is combinational, but $display makes it non-synthesizable.
    $display("DEBUG: Current data_in (combinational check): %h", data_in); // Second occurrence
  end

endmodule
