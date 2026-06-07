module starc05_2_2_2_3b_ex1(output reg a);
 reg clk;

 initial begin
  clk = 1'b0;
  a = 1'b0; // Initialize 'a' to 0 from time 0, matching the original problematic 'always' block's intent.
  forever #5 clk = ~clk; // Generate a clock for simulation
 end

 always @(posedge clk) begin // W421 fix: Added event control to the always block.
  a <= 1'b0; // 'a' is driven synchronously to 0.
 end
endmodule
