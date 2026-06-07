// This re-declaration of 'processor_core' will trigger STX_VE_589.
// It will be flagged as previously declared at line 1.
module processor_core (
  input wire rst_ni,
  output wire ready_o
);
  assign ready_o = rst_ni;
endmodule
