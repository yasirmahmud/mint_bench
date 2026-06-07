module long_always_ex2(input clk, output reg out);
  always @(posedge clk) begin
    out <= 1'b0;
    out <= 1'b1;
  end
endmodule
