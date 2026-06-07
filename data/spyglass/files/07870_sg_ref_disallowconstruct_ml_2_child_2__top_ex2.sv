module top_ex2;
  // W287a: Input 'clk_sig' undriven. Added a clock generator.
  reg clk_sig_reg;
  initial begin
    clk_sig_reg = 0;
    forever #5 clk_sig_reg = ~clk_sig_reg;
  end
  wire clk_sig = clk_sig_reg; // Use a wire for connecting to instances

  // W287b: Instance output port 'result' not connected. Added wires.
  // 'result' is 1-bit in bottom_ex2, so these wires are 1-bit.
  wire result_b1;
  wire result_b2;

  bottom_ex2 #(1) b1 (.clk(clk_sig), .result(result_b1));
  bottom_ex2 #(2) b2 (.clk(clk_sig), .result(result_b2));
endmodule
