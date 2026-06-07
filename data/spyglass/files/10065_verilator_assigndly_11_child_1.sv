module example_11 (
  input clk
);
  reg p;
  reg q;
  always @(negedge clk) begin
    p <= q;
  end
endmodule
