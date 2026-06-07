module w345_ex2;
 reg clk;

 // Fix for W123: 'clk' read but never set. Added an initial block to drive clk.
 initial begin
  clk = 0;
  forever #5 clk = ~clk; // Generate a 10ns period clock
 end

 task my_task;
 // Fix for SYNTH_196: Task should not have event control statements.
 // Removed @(posedge clk) from the task body.
 begin
  // Original: @(posedge clk);
  // No specific action required inside this task now, as per the minimal original intent.
 end
 endtask

endmodule
