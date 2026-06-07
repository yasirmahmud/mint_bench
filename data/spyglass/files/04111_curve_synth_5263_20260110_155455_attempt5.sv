module curve_synth_5263_20260110_155455_attempt5 (
  input clk,
  input reset,
  output reg out_a,
  output reg out_b
);

  // SYNTH_5263 violation 1: Using 'fork...join_none' construct.
  // This construct is unsynthesizable and triggers the target rule.
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      out_a <= 1'b0;
    end else begin
      fork : first_violation
        out_a <= 1'b1; // Consistent non-blocking assignment
      join_none
    end
  end

  // SYNTH_5263 violation 2: Using 'fork...join_any' construct.
  // This construct is also unsynthesizable and distinct from 'fork...join' or 'fork...join_none'.
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      out_b <= 1'b0;
    end else begin
      fork : second_violation
        begin
          #10 out_b <= 1'b1; // Non-blocking assignment with a delay
        end
      join_any
    end
  end

endmodule
