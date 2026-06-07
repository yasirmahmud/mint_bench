// Second declaration of 'data_aggregator'.
// This re-declaration triggers the first STX_VE_589 violation.
// It will reference the initial declaration at line 7.
module data_aggregator (
  input wire [7:0] data_in,
  output wire data_ready_o
);

  assign data_ready_o = (data_in != 8'h00);

endmodule
