module example_03(input clk, input c);
  always @(posedge clk) begin
    c <= 1'b1;
  end
endmodule
