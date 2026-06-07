module example_10 (
  input a,
  output logic y
);
  logic internal_sig;

  always_comb begin
    // Fix ALWCOMBORDER: Ensure 'internal_sig' is assigned before being read by 'y'
    internal_sig = a;
    y = internal_sig;
  end
endmodule
