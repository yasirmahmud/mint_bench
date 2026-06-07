module clkdata11 (input clk, output reg out);
  always @(posedge clk) begin
    out <= clk ^ 1'b1;
  end
endmodule
