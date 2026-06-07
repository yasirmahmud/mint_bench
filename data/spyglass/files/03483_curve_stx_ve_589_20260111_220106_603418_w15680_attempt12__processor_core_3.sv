// This third declaration of 'processor_core' will also trigger STX_VE_589.
// It will be flagged as previously declared at line 1, resulting in a second violation report.
module processor_core (
  input wire en_i,
  output wire busy_o
);
  assign busy_o = en_i;
endmodule
