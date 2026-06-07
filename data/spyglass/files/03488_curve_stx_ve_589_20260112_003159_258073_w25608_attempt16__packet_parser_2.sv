// Second declaration of 'packet_parser'.
// This re-declaration triggers the first STX_VE_589 violation.
// It will reference the initial declaration at line 7.
module packet_parser (
  input wire [31:0] packet_data_i,
  output wire data_valid_o
);

  assign data_valid_o = (packet_data_i != 32'h0);

endmodule
