module w345_ex2 (
    input clk
);

 // The 'initial' block that generated 'clk' has been removed.
 // This resolves SYNTH_5143 (Initial block is ignored for synthesis).
 // 'clk' has been changed from a 'reg' to an 'input' port, signifying it is driven externally.
 // This also resolves CheckDelayTimescale-ML as the delay statement is no longer present.
 // The previous fix for W123 ('clk' read but never set) is addressed by 'clk' now being an input.

 task my_task;
 // Fix for SYNTH_196: Task should not have event control statements.
 // Removed @(posedge clk) from the task body.
 begin
  // Original: @(posedge clk);
  // No specific action required inside this task now, as per the minimal original intent.
 end
 endtask

endmodule
