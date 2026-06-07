module clkdata4 (input clk, input data_in, output reg out);
  always @(posedge clk) begin
    if (clk) out <= data_in;
  end
endmodule
