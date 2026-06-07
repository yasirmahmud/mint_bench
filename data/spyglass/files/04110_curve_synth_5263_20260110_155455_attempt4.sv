module curve_synth_5263_20260110_155455_attempt4 (
  input clk,
  input reset,
  output reg out_a,
  output reg out_b,
  output reg out_c
);

  // SYNTH_5263 violation 1: Using 'fork...join_none' construct.
  // This construct is unsynthesizable and triggers the target rule.
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      out_a <= 1'b0;
    end else begin
      // This fork/join_none executes its content in parallel and continues immediately without waiting.
      fork : first_violation
        out_a <= 1'b1;
      join_none
    end
  end

  // SYNTH_5263 violation 2: Using 'fork...join' with multiple parallel blocking assignments.
  // This construct is also unsynthesizable, demonstrating parallel execution of assignments.
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      out_b <= 1'b0;
      out_c <= 1'b0;
    end else begin
      // This fork/join executes both blocks in parallel and waits for all of them to complete.
      fork : second_violation
        begin
          out_b = 1'b1; // Blocking assignment in parallel block
        end
        begin
          out_c = 1'b1; // Another blocking assignment in parallel block
        end
      join
    end
  end

endmodule
