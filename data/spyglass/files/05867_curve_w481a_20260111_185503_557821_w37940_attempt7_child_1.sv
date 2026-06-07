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
      // This 'for' loop originally triggered W481a because its step variable 'loop_idx'
      // was not directly used in the loop condition '!stop_loop_flag'.
      // Fix: The loop condition is changed to 'loop_idx <= 6' to directly use 'loop_idx'.
      // This ensures the loop terminates after 7 iterations (for loop_idx from 0 to 6),
      // preserving the original functional behavior where 'stop_loop_flag'
      // is set to 1'b1 when loop_idx reaches 6.
      for (loop_idx = 0; loop_idx <= 6; loop_idx = loop_idx + 1) begin // W481a fix: loop_idx in condition
        if (loop_idx > 5) begin
          stop_loop_flag = 1'b1; // 'stop_loop_flag' is set here, ensuring final_val becomes 1'b1.
        end
        // The `loop_idx` variable is read by the `if` condition and also by the step expression.
      end
      final_val = stop_loop_flag; // 'stop_loop_flag' is read here to prevent W528.
    end
    // The implicit else for `final_val` is handled by its default assignment at the beginning of the `always` block.
  end

endmodule
