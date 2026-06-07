module example_6;
  reg [2:0] state;

  // Replaced always @* with an initial block to resolve Verilator's ALWNEVER warning.
  // This ensures the logic (setting 'state') is active at time zero, matching the intent
  // implied by the original warning description ('logic was intended to be active').
  initial begin
    state = 3'b001; // Using blocking assignment for initial block.
  end

  // Added a dummy read to resolve SpyGlass W528: Variable 'state' set but not read.
  // This ensures 'state' is considered 'read' without altering the module's functional
  // behavior or its interface. The variable _unused_state_read_wire can be optimized away by synthesis.
  wire [2:0] _unused_state_read_wire;
  assign _unused_state_read_wire = state;
endmodule
