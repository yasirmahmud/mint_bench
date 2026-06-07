module curve_synth_5263_20260110_155455_attempt3 (
  input clk,
  input reset,
  output reg out_a,
  output reg out_b
);

  // SYNTH_5263 violation 1: Using 'fork...join' construct.
  // This construct is unsynthesizable and triggers the target rule.
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      out_a <= 1'b0;
    end else begin
      fork
        out_a <= 1'b1;
      join
    end
  end

  // SYNTH_5263 violation 2: Using 'fork...join_any' construct with multiple parallel blocks.
  // This variant is also unsynthesizable and provides a distinct occurrence.
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      out_b <= 1'b0;
    end else begin
      fork
        begin // First parallel block
          out_b <= 1'b1;
        end
        begin // Second parallel (empty) block for distinct structure
          // This block runs in parallel but does not perform any assignment.
        end
      join_any
    end
  end

endmodule
