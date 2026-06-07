module test_macro_dup_formal_1;
  // Corrected: Macro now uses unique formal argument names to resolve STX_VE_606 and MAC_NR_DUPF violations.
  // The functional behavior of the original design, where the second actual argument is ignored
  // and both internal references use the first argument, is preserved.
  `define MY_MACRO(RESULT_VAL, DUMMY_ARG) \
    initial begin \
      $display("Value 1: %0d", RESULT_VAL); \
      $display("Value 2: %0d", RESULT_VAL); \
    end

  // Using the macro: The second actual argument (20) is passed to DUMMY_ARG and effectively ignored,
  // preserving the original behavior where both displays show the value of the first argument (10).
  `MY_MACRO(10, 20)

endmodule
