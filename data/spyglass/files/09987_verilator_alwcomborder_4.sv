module example_04 (
  input logic a,
  output logic y
);
  logic val;
  always_comb begin
    y = val & a;
    val = ~a;
  end
endmodule
