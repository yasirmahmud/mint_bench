module test_macro_dup_formal_2;
  // Macro with duplicate formal argument 'ARG_A'
  `define ANOTHER_MACRO(ARG_A, ARG_B, ARG_A, ARG_C)
    initial begin
      $display("First ARG_A: %0d", ARG_A);
      $display("ARG_B: %0d", ARG_B);
      $display("Second ARG_A (will be first): %0d", ARG_A);
      $display("ARG_C: %0d", ARG_C);
    end

  // Using the macro, the third actual argument (30) will be ignored
  `ANOTHER_MACRO(10, 20, 30, 40)

endmodule
