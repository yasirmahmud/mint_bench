module curve_synth_130_20260112_011749_894044_w37744_attempt14 (
    // Inputs
    source_a,
    source_b,
    gate_control_c,
    gate_control_d,
    // Outputs
    out_q1,
    out_q2,
    out_q3,
    out_q4,
    out_q5
);

input source_a;
input source_b;
input gate_control_c;
input gate_control_d;

output out_q1;
output out_q2;
output out_q3;
output out_q4;
output out_q5;

wire out_q1;
wire out_q2;
wire out_q3;
wire out_q4;
wire out_q5;

  // Each nmos instance below will trigger a SYNTH_130 violation (nmos gate types are not supported)
  nmos nmos_t1 (out_q1, source_a, gate_control_c);
  nmos nmos_t2 (out_q2, source_b, gate_control_d);
  nmos nmos_t3 (out_q3, source_a, gate_control_d);
  nmos nmos_t4 (out_q4, 1'b0, gate_control_c);
  nmos nmos_t5 (out_q5, source_b, 1'b1);

endmodule
