module curve_synth_5235_20260111_220322_596091_w38092_attempt12 (
  input [15:0] data_in_a,
  input [7:0] data_in_b,
  output [15:0] data_out_div,
  output [7:0] data_out_mod
);

  // SYNTH_5235 violation 1: Division by a parameter that evaluates to zero.
  // The parameter 'DIVISOR_PARAM_ZERO' is explicitly calculated to be zero.
  parameter DIVISOR_PARAM_ZERO = 16'd50 - 16'd50;
  assign data_out_div = data_in_a / DIVISOR_PARAM_ZERO;

  // SYNTH_5235 violation 2: Modulo by an explicit constant zero.
  // This uses a different operation (modulo) and an explicit hex constant zero.
  assign data_out_mod = data_in_b % 8'h0;

endmodule
