module InvalidVariedTypedefNameStyle_ex1 (
  input wire clk,
  input wire rst_n, // Active-low reset
  output my_enum_type out_current_state
);

  // Original typedef declaration
  typedef enum { STATE_IDLE, STATE_RUN } my_enum_type;

  // State variable
  my_enum_type current_state;

  // Synthesizable always block to replace the initial block.
  // This resolves SYNTH_5143 by making the initialization synthesizable.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      current_state <= STATE_IDLE; // Initialize state on reset
    end else begin
      // No state transition logic is specified in the original design
      // (beyond the initial value), so the state remains constant or
      // would be updated by further logic. For this minimal fix,
      // we make it stay in IDLE after reset.
      current_state <= STATE_IDLE;
    end
  end

  // Assign current_state to an output to resolve W528.
  // This ensures the 'current_state' variable is read.
  assign out_current_state = current_state;

endmodule
