module test_macro_naming_violation_1;
  `define MY_DEFINE_VALUE 10

  initial begin
    $display("The value is: %0d", `MY_DEFINE_VALUE);
  end
endmodule
