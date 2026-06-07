module example_18 (
  input logic a,
  output logic y
);
  logic data_out_reg;
  always_comb begin
    y = data_out_reg;
    data_out_reg = a;
  end
endmodule
