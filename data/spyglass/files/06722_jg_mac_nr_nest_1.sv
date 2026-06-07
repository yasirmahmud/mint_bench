module nested_macro_example_1();
  `define INNER_MACRO 10
  `define OUTER_MACRO `INNER_MACRO + 5

  initial begin
    $display("Value: %0d", `OUTER_MACRO);
  end
endmodule
