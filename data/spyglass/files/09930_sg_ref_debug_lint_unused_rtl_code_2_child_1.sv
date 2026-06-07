module unused_rtl_code_ex2 (input clk, output reg out);
  always @(posedge clk) begin
    out <= 1'bx;
  end
endmodule
