`timescale 1ns/1ps
module curve_synth_5143_20260111_231215_369225_w15680_attempt11 ();

  reg [3:0] startup_counter; // Internal register for simulation-only use

  // SYNTH_5143: Initial block is ignored for synthesis
  // This initial block contains simulation-only logic, including a 'repeat' loop
  // and assignments to a local register, all of which will be ignored by synthesis tools.
  // synthesis translate_off
  initial begin
    startup_counter = 4'h0; // This assignment is for simulation only
    repeat (3) begin
      $display("SIMULATION: Initializing startup counter... value = %d", startup_counter); 
      #1; // Delay is simulation-only
      startup_counter = startup_counter + 1; // Simulation-only increment
    end
    $display("SIMULATION: Initial setup sequence complete. Final counter value: %d", startup_counter);
  end
  // synthesis translate_on

  // No other synthesizable logic is present to ensure only SYNTH_5143 is triggered.
  // 'startup_counter' is not an output and not used in any synthesizable 'always' or 'assign' block.
  // Thus, it will be optimized away (or ignored) by synthesis, and its assignments within
  // the initial block are the core demonstration of the SYNTH_5143 rule.

endmodule
