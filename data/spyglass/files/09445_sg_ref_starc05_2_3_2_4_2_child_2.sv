module starc05_2_3_2_4_ex2 (input clk);
  // To resolve 'Input 'clk' declared but not read' violation (W240),
  // we add a dummy register that uses the clock signal.
  reg dummy_signal;

  always @(posedge clk) begin
    dummy_signal <= 1'b0;
  end
endmodule
