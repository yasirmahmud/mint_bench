module clkdata17 (input clk, output reg out);
  always @(posedge clk) begin
    out <= clk + 1'b0;
  end
endmodule
