module example_10 (
  input logic a,
  output logic y
);
  logic internal_sig;
  always_comb begin
    y = internal_sig;
    internal_sig = a;
  end
endmodule
