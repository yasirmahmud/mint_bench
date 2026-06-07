module example_07 (
  input a,
  output y
);
  reg data_in;
  always_comb begin
    data_in = a;
    y = data_in;
  end
endmodule
