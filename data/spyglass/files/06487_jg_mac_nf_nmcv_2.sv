module test_macro_naming_violation_2;
  `define another_macro_const 20

  initial begin
    $display("Another value is: %0d", `another_macro_const);
  end
endmodule
