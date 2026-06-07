module example_09 (
  input logic a,
  output logic y
);
  logic out_reg;
  always_comb begin
    y = out_reg;
    out_reg = a;
  end
endmodule
