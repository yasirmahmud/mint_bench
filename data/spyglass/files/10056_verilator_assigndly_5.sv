module example_05;
  reg g;
  reg h;
  always @(posedge clk) begin
    g <= #15 h;
  end
  reg clk;
  initial clk = 0;
endmodule
