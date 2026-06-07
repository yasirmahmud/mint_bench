module example_16;
  reg w;
  reg x;
  always @(x) begin
    w = #10 x;
  end
endmodule
