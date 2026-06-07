module example_16 (
  input wire a,
  output wire y
);
  wire p_val;
  always_comb begin
    p_val = a; // Resolved ALWCOMBORDER: p_val is now assigned before being read
    y = p_val;
  end
endmodule
