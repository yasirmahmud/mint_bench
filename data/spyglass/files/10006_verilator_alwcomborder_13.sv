module example_13 (
  input logic a,
  output logic y
);
  logic control;
  always_comb begin
    y = control ? 1'b1 : 1'b0;
    control = a;
  end
endmodule
