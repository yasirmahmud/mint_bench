module example_05 (
  input logic a,
  input logic b,
  output logic y
);
  logic result;
  always_comb begin
    y = result | b;
    result = a & b;
  end
endmodule
