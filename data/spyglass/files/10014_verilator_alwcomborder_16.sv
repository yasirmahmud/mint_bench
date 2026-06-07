module example_16 (
  input logic a,
  output logic y
);
  logic p_val;
  always_comb begin
    y = p_val;
    p_val = a;
  end
endmodule
