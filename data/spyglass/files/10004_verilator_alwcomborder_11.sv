module example_11 (
  input logic a,
  input logic b,
  output logic y
);
  logic x;
  always_comb begin
    y = x + b;
    x = a;
  end
endmodule
