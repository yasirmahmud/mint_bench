module example_15 (
  input logic a,
  output logic y
);
  logic status_bit;
  always_comb begin
    y = status_bit;
    status_bit = a;
  end
endmodule
