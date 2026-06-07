module curve_synth_77_20260111_154018_106011_w21676_attempt8 (
    input wire condition,
    input wire [7:0] data_in_blocking,
    input wire [7:0] data_in_nonblocking,
    output reg [7:0] target_variable
);

  // This 'always @(*)' block describes combinational logic.
  // The issue arises because the variable 'target_variable' receives
  // both a blocking assignment ('=') and a non-blocking assignment ('<=')
  // within the same procedural block, potentially in the same simulation time step.
  // This creates a semantic conflict, making the final value of 'target_variable'
  // ambiguous for synthesis and simulation, which triggers SYNTH_77.
  always @(*) begin
    // Blocking assignment: This assignment is always executed first and immediately updates 'target_variable'.
    target_variable = data_in_blocking; 

    // Non-blocking assignment: If 'condition' is true, this assignment is scheduled
    // to update 'target_variable' at the end of the current simulation time step.
    // This simultaneous presence of an immediate blocking assignment and a scheduled
    // non-blocking assignment to the same 'reg' variable within 'always @(*)'
    // causes the SYNTH_77 violation.
    if (condition) begin
      target_variable <= data_in_nonblocking; 
    end
    // No explicit 'else' is needed for the non-blocking assignment path here
    // because the blocking assignment always provides a base value,
    // preventing latch inference due to unassigned paths for 'target_variable'.
  end

endmodule
