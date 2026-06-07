module example_11;
  reg p;
  reg q;
  always @(negedge clk) begin
    p <= #25 q;
  end
  reg clk;
  initial clk = 0;
endmodule
