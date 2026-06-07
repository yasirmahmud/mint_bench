module example_07 (
  input logic a,
  output logic y
);
  logic data_in;
  always_comb begin
    y = data_in;
    data_in = a;
  end
endmodule
