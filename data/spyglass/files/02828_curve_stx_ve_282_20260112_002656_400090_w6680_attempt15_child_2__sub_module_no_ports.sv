module sub_module_no_ports ();
  // This submodule intentionally has no ports defined.
  // FIX: Added a dummy wire to resolve WarnAnalyzeBBox (empty definition violation).
  wire dummy_lint_fix_signal;
endmodule
