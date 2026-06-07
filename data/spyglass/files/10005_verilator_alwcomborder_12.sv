module example_12 (
  input logic [1:0] a,
  output logic y
);
  logic [1:0] vec;
  always_comb begin
    y = vec[1];
    vec = a;
  end
endmodule
