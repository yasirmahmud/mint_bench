module curve_synth_5166_20260111_175739_553561_w36056_attempt7 (
  input wire [7:0] data_in,
  input wire       enable
);

  // Dummy assignments to resolve W240 for unused inputs in synthesized design.
  // These wires will be optimized away by synthesis, preserving no functional change.
  wire [7:0] unused_data_in_read;
  wire       unused_enable_read;
  assign unused_data_in_read = data_in;
  assign unused_enable_read   = enable;

  // This $display statement is non-synthesizable and will trigger SYNTH_5166
  // Placing it in an always block rather than an initial block to avoid SYNTH_5143.
  // Using synthesis pragmas to ignore this block during synthesis, resolving SYNTH_5166.
  // synopsys translate_off
  always @(posedge enable) begin
    $display("INFO: Enable toggled. Data_in value: %h", data_in); // First occurrence
  end
  // synopsys translate_on

  // Another non-synthesizable $display to meet the requirement of 2 occurrences.
  // Using synthesis pragmas to ignore this block during synthesis, resolving SYNTH_5166.
  // synopsys translate_off
  always @(*) begin
    // This block is combinational, but $display makes it non-synthesizable.
    $display("DEBUG: Current data_in (combinational check): %h", data_in); // Second occurrence
  end
  // synopsys translate_on

endmodule
