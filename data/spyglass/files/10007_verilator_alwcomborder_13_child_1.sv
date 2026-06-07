module example_13 (
  input a,
  output y
);
  input a;
  output y;

  reg y;

  always @* begin
    y = a;
  end
endmodule
