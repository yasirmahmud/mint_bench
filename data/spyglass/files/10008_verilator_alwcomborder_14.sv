module example_14 (
  input logic a,
  output logic y
);
  logic buffer_var;
  always_comb begin
    y = buffer_var;
    buffer_var = a;
  end
endmodule
