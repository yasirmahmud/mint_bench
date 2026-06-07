module curve_w352_20260111_031016_attempt2;
  integer i; // 'integer' is signed by default in Verilog-2001

  initial begin
    // W352: The 'for' condition is constant - the loop will either never execute or never terminate
    // In this case, 'i' is initialized to 0. Since 'i' is a signed integer, the condition 'i < 0' is false initially.
    // As 'i' only increments (i = i + 1), it will always remain >= 0, or eventually overflow to a large positive number before potentially becoming negative due to wrap-around, at which point the loop would have long ceased to be relevant. Critically, for the initial evaluation and any subsequent checks, the condition 'i < 0' remains effectively false for typical loop bounds and integer sizes.
    // Therefore, the condition 'i < 0' is effectively constant false, meaning the loop will never execute.
    // The loop variable 'i' is explicitly used in the condition, which helps to avoid W481a.
    for (i = 0; i < 0; i = i + 1) begin
      // This code will never be reached.
    end
  end
endmodule
