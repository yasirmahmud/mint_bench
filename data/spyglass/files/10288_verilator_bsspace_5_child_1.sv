module test5;
  logic clk, reset, q;
  always @(posedge clk) begin
    if (reset) begin
      q <= 0;
    end
  end
endmodule
