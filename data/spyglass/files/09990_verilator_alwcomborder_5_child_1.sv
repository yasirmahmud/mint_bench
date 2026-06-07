module example_05 (
  input wire a,
  input wire b,
  output wire y
);
  wire result;
  always_comb begin
    result = a & b;
    y = result | b;
  end
endmodule
