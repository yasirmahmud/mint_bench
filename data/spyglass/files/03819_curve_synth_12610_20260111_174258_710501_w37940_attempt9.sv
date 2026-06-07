module curve_synth_12610_20260111_174258_710501_w37940_attempt9 (
  input wire clk,
  input wire rst_n,
  input wire event_start,
  input wire event_end,
  output wire dummy_output
);

  // SYNTH_12610: Sequence blocks will be ignored for synthesis due to large delay range.
  // The delay range [0:1024] is considered large by synthesis tools, leading to this warning.
  sequence large_delay_range_sequence;
    @(posedge clk) event_start ##[0:1024] event_end;
  endsequence

  // Use all inputs and output to prevent W240 (unused signal) warnings.
  // Note: Usage within a 'sequence' often does not prevent W240 in static analysis tools,
  // hence the explicit combinational assignment to ensure full signal utilization.
  assign dummy_output = clk & rst_n & event_start & event_end;

endmodule
