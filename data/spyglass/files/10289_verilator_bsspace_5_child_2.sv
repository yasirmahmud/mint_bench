module test5;
  logic clk, reset, q;

  // Clock generation to resolve undriven 'clk' violation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // Generate a clock with 10 time unit period
  end

  // Reset generation to resolve undriven 'reset' violation
  initial begin
    reset = 1; // Assert reset initially
    #15 reset = 0; // Deassert reset after 15 time units
    #50 $finish; // End simulation after 50 more time units
  end

  // Monitor 'q' to resolve the 'q' set but not read violation (W528)
  initial begin
    $monitor("Time=%0t, clk=%b, reset=%b, q=%b", $time, clk, reset, q);
  end

  always @(posedge clk) begin
    if (reset) begin
      q <= 0;
    end
    // When reset is low, 'q' implicitly holds its value, preserving the original behavior.
  end
endmodule
