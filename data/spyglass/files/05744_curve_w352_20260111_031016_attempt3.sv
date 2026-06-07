module curve_w352_20260111_031016_attempt3;

  integer i;

  initial begin
    // W352: The 'for' condition is constant - the loop will either never execute or never terminate
    // In this case, the condition '1'b0' is a literal constant false.
    // Therefore, the loop will never execute.
    // This example is distinct from previous attempts by using a literal constant false condition
    // which makes the loop never execute, unlike the context examples that use constant true (infinite loop).
    for (i = 0; 1'b0; i = i + 1) begin
      // This code block is unreachable as the loop condition is constant false.
      // 'i' is used in the loop initialization, condition, and increment to minimize W481a (unused signal).
    end
  end

endmodule
