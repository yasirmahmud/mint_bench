module curve_w352_20260112_012928_111180_w47152_attempt21 (
  input wire clk,
  input wire rst_n,
  output reg dummy_out
);

  integer i; // Loop variable for the 'for' loop

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      dummy_out <= 1'b0;
    end else begin
      // W352 violation: The 'for' condition is constant.
      // The condition (10 < 5) is a constant expression that always evaluates to false.
      // Therefore, the loop will never execute, triggering W352.
      for (i = 0; 10 < 5; i = i + 1) begin
        // The loop body is unreachable as the condition is constantly false.
        // It is kept empty to minimize other potential violations.
      end

      // 'dummy_out' is assigned here to ensure it is used and reachable,
      // as the 'for' loop above never executes. This avoids W481a (unused signal).
      dummy_out <= 1'b1;
    end
  end

endmodule
