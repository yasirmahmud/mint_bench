`timescale 1ns/1ps
module NoTimeOut_ex1 (
  input some_signal // Added as input to resolve W123
);
  // `some_signal` is now an input, so no `reg` declaration is needed here.
  // The initial block was removed because it is ignored for synthesis (SYNTH_5143 violation).
  // If hardware implementation of timeout logic is required, it needs to be redesigned
  // using synthesizable constructs (e.g., always blocks, clock, reset, counters).
endmodule
