module curve_w481a_20260111_185503_557821_w37940_attempt7 (
  input wire en,
  output reg final_val
);

  integer loop_idx;
  reg stop_loop_flag;

  always @* begin
    // Initialize variables to default states to prevent latch inference or undefined values.
    stop_loop_flag = 1'b0; // Default assignment for combinational logic
    loop_idx = 0;
    final_val = 1'b0; // Default output assignment

    if (en) begin
      // This 'for' loop triggers W481a.
      // 'loop_idx' is the step variable (incremented in the third part of the 'for' statement).
      // The loop condition '!stop_loop_flag' does NOT directly use 'loop_idx'.
      // This matches the rule description: "step variable 'i' is not used in condition".
      // The loop is made to terminate by modifying 'stop_loop_flag' based on 'loop_idx' inside the loop,
      // preventing a W352 (constant true end condition) violation.
      for (loop_idx = 0; !stop_loop_flag; loop_idx = loop_idx + 1) begin
        if (loop_idx > 5) begin
          stop_loop_flag = 1'b1; // 'stop_loop_flag' is set here, eventually terminating the loop.
        end
        // The `loop_idx` variable is read by the `if` condition and also by the step expression.
      end
      final_val = stop_loop_flag; // 'stop_loop_flag' is read here to prevent W528.
    end
    // The implicit else for `final_val` is handled by its default assignment at the beginning of the `always` block.
  end

endmodule
