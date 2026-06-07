module test5;
  always @(posedge clk) begin
    if (reset) begin
      q <= 0; \

    end
  end
  logic clk, reset, q;
endmodule
