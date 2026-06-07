module example_09 (
  input a,
  output reg y
);
  reg out_reg;
  always_comb begin
    out_reg = a;
    y = out_reg;
  end
endmodule
