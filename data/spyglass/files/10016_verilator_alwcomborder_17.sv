module example_17 (
  input logic a,
  output logic y
);
  logic temp_q;
  always_comb begin
    y = temp_q;
    temp_q = a;
  end
endmodule
