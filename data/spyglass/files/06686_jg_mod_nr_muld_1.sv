module example_1 (input clk);
  reg a, b; // Multiple declarations on one line
  always @(posedge clk) begin
    a <= 1'b0;
    b <= 1'b1;
  end
endmodule
