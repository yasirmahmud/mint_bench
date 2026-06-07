module top_module (
  input wire in_sig,
  output wire out_sig
);

  // First occurrence of `end_keywords inside a design element
  `end_keywords

  assign out_sig = in_sig;

  // Second occurrence of `end_keywords inside a design element
  `end_keywords

endmodule
