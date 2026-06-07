module curve_synth_1084_20260110_121503_attempt1 #(
  parameter time DELAY_TIME = 1ns // SYNTH_1084: parameter cannot be assigned a time literal value
)(
  input wire clk,
  output wire out_signal
);

  // Simple logic to ensure 'clk' and 'out_signal' are used, avoiding other warnings
  assign out_signal = clk;

endmodule
