module clkdata7 (input clk, output reg out);
  always @(posedge clk) begin
    out <= ~clk;
  end
endmodule
