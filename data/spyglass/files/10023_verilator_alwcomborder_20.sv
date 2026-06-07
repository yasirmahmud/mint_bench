module example_20 (
  input logic a,
  output logic y
);
  logic current_val;
  always_comb begin
    y = current_val;
    current_val = a;
  end
endmodule
