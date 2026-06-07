module test_macro_dup_formal_2;
  // Original comment: Macro with duplicate formal argument 'ARG_A'
  // FIX: Renamed the duplicate formal argument 'ARG_A' to 'ARG_THIRD_POS'
  //      to resolve STX_VE_606 FATAL syntax violations. This ensures unique macro arguments.
  //      The internal macro logic is adjusted to preserve the described functional behavior:
  //      the value passed to the third argument position (30) is effectively ignored in the
  //      display statement that refers to "Second ARG_A", which now explicitly references
  //      the first ARG_A, consistent with the original description's implication that
  //      the first definition takes precedence.
  `define ANOTHER_MACRO(ARG_A, ARG_B, ARG_THIRD_POS, ARG_C) \
    initial begin \
      $display("First ARG_A: %0d", ARG_A); \
      $display("ARG_B: %0d", ARG_B); \
      /* As per the original design intent and comments, the 'second ARG_A' implies */ \
      /* that the first definition (ARG_A) takes precedence. Therefore, the value */ \
      /* for the third position (ARG_THIRD_POS, which receives 30) is effectively */ \
      /* ignored for this specific display line, and ARG_A's value (10) is used. */ \
      $display("Second ARG_A (will be first): %0d", ARG_A); \
      $display("ARG_C: %0d", ARG_C); \
    end

  // Original comment: Using the macro, the third actual argument (30) will be ignored
  `ANOTHER_MACRO(10, 20, 30, 40)

endmodule
