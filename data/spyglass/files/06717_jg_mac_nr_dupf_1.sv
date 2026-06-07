module test_macro_dup_formal_1;
  // Macro with duplicate formal argument 'RESULT'
  `define MY_MACRO(RESULT, RESULT)
    initial begin
      $display("Value 1: %0d", RESULT);
      $display("Value 2: %0d", RESULT);
    end

  // Using the macro, the second actual argument (20) will be ignored
  `MY_MACRO(10, 20)

endmodule
