module curve_synth_77_20260111_154018_106011_w21676_attempt7 (
    input wire select_blocking_path,
    input wire [7:0] input_data_blocking,
    input wire [7:0] input_data_nonblocking,
    output reg [7:0] target_variable_for_synth77
);

  // This 'always' block causes SYNTH_77 violation by assigning to 'target_variable_for_synth77'
  // using both blocking ('=') and non-blocking ('<=') assignments within the same procedural block.
  // This design avoids an explicit clock edge to prevent W336 and ensures all paths assign a value
  // to prevent latch inference.
  always @(*) begin
    if (select_blocking_path) begin
      target_variable_for_synth77 = input_data_blocking; // Blocking assignment
    end else begin
      // This path provides a non-blocking assignment for 'target_variable_for_synth77'.
      // The presence of both blocking and non-blocking assignments to the same 'reg' variable
      // within this single 'always' block triggers the SYNTH_77 rule.
      target_variable_for_synth77 <= input_data_nonblocking; // Non-blocking assignment
    end
  end

endmodule
