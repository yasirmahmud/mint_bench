module curve_synth_1084_20260110_121503_attempt4 (
  input wire clk_i,
  output wire out_o
);

  parameter PROPAGATION_DELAY = 500ns; // SYNTH_1084: parameter cannot be assigned a time literal value

  // Simple logic to ensure 'clk_i' and 'out_o' are used
  assign out_o = clk_i;

endmodule
