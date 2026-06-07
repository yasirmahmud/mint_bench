module curve_synth_5142_20260112_003925_689579_w6680_attempt13 (
  input wire clk,
  input wire rst_n,
  input wire data_in,
  output wire data_out
);

  // Simple logic to ensure all inputs/outputs are used and avoid other warnings.
  assign data_out = data_in; 

  // This specify block contains a $recovery timing check, which is purely
  // for simulation and is ignored by synthesis tools. This triggers exactly
  // one SYNTH_5142 violation.
  specify
    // $recovery(control_event, data_event, limit)
    // Checks that the data_event (negedge rst_n) does not occur within 'limit' time
    // after the control_event (posedge clk). This is a simulation-only check.
    $recovery(posedge clk, negedge rst_n, 10);
  endspecify

endmodule
