module disallowed_sub_ex1 (
  input  dummy_in,
  output dummy_out
);
  // Added dummy logic to resolve 'Design Unit has empty definition' warning.
  // This creates a minimal, non-empty definition without functional impact.
  assign dummy_out = dummy_in;
endmodule
