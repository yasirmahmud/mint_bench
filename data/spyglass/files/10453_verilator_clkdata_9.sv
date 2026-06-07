module clkdata9 (input clk, output reg out);
  reg temp_reg;
  always @(posedge clk) begin
    temp_reg <= clk;
  end
  assign out = temp_reg;
endmodule
