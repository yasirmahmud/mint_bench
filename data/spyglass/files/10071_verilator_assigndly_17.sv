module example_17;
  reg y;
  reg z;
  always @(posedge clk) begin
    y <= #50 z;
  end
  reg clk;
  initial clk = 0;
endmodule
