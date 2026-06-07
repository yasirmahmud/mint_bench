module forever_example_2();
  reg clk;

  initial begin
    clk = 0;
    forever #5 clk = ~clk; // Clock generation using forever
  end
endmodule
