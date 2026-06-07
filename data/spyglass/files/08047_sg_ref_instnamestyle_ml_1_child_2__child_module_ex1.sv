module child_module_ex1();
  wire dummy_signal; // Added to resolve "empty definition" warning
  assign dummy_signal = 1'b0; // Added to provide actual content/logic to resolve WarnAnalyzeBBox
 endmodule
