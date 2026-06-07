module example_10;
  reg n;
  reg o;
  always @(o) begin
    n = #2 o;
  end
endmodule
