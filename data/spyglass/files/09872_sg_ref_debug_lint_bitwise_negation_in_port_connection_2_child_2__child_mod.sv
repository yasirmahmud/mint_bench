module child_mod (input i, output o);
  // Drive an output with 'i' to resolve 'input declared but not read' (W240)
  // and make the module definition non-empty (WarnAnalyzeBBox).
  assign o = i;
endmodule
