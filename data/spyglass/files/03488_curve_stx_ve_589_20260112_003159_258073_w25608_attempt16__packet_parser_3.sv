// Third declaration of 'packet_parser'.
// This re-declaration triggers the second STX_VE_589 violation.
// It will also reference the initial declaration at line 7.
module packet_parser (
  input wire start_parsing_i,
  output wire parsing_done_o
);

  assign parsing_done_o = start_parsing_i;

endmodule
