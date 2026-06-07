`define MY_MACRO_EX2 1

module lint_undefined_macro_ex2;
  `ifdef MY_MACRO_EX2
    reg a;
  `endif

  initial begin
    $display("Hello");
  end
endmodule
