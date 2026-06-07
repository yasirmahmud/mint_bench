// Second declaration of 'fifo_controller'.
// This re-declaration triggers the first STX_VE_589 violation.
// It will reference the initial declaration at line 5.
module fifo_controller (
  input wire read_en,
  output wire [7:0] data_out
);

  assign data_out = read_en ? 8'hAA : 8'h00;

endmodule
