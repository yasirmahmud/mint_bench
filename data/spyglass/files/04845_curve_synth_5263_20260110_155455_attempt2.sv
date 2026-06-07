module curve_synth_5263_20260110_155455_attempt2 (
  input clk,
  input reset,
  input in_data,
  output reg out_syn_1,
  output reg out_syn_2,
  output reg out_fork_1,
  output reg out_fork_2
);

  // This block contains clearly synthesizable logic.
  // It is included to ensure the module is not entirely unsynthesizable,
  // aiming to prevent general synthesis errors like 'ErrorAnalyzeBBox' and focus on SYNTH_5263.
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      out_syn_1 <= 1'b0;
      out_syn_2 <= 1'b0;
    end else begin
      out_syn_1 <= in_data;
      out_syn_2 <= out_syn_1;
    end
  end

  // First SYNTH_5263 violation: using a 'fork...join' construct.
  // This construct is not synthesizable in RTL.
  always @(posedge clk) begin
    fork
      out_fork_1 <= 1'b1;
    join
  end

  // Second SYNTH_5263 violation: using a 'fork...join_any' construct.
  // This provides a distinct unsynthesizable construct to ensure two errors are reported.
  always @(posedge cllk) begin
    fork
      out_fork_2 <= 1'b0;
    join_any
  end

endmodule
