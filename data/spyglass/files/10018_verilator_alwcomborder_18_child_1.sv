module example_18 (
  input a,
  output reg y
);
  reg data_out_reg;
  always_comb begin
    data_out_reg = a;
    y = data_out_reg;
  end
endmodule
