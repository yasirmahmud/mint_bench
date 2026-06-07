module redef_macro_example1();
  `define MY_VALUE 10

  // Some code that might use MY_VALUE
  initial begin
    $display("Initial value: %0d", `MY_VALUE);
  end

  // Redefining the macro
  `define MY_VALUE 20

  initial begin
    $display("Redefined value: %0d", `MY_VALUE);
  end

endmodule
