module curve_w481a_example_1 (
  input wire clk
);

  reg loop_condition_var = 1'b1;
  integer i;

  always @(posedge clk) begin
    // W481a: step variable 'i' is not used in the loop condition 'loop_condition_var'
    for (i = 0; loop_condition_var; i = i + 1) begin
      // The loop is made bounded (3 iterations: i=0,1,2) by modifying 'loop_condition_var'
      // based on 'i' inside the loop body. This prevents SYNTH_5143 (unbounded loop).
      if (i == 2) begin
        loop_condition_var = 1'b0;
      end
    end
    // Reset 'loop_condition_var' for the next clock cycle so the loop can execute again.
    // This ensures 'loop_condition_var' is always defined at the start of the loop.
    loop_condition_var = 1'b1;
  end

endmodule
