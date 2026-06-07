module clkdata2 (input clk, output reg out);
  always @(posedge clk) begin
    out <= clk;
  end
endmodule
