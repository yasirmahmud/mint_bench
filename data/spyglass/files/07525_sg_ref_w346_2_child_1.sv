module my_module_ex2 (input clk, input rst);
 always @(posedge clk) begin
  my_task;
 end

 task my_task;
  // Event control statements removed to resolve SYNTH_196 violation.
  // Tasks called from 'always' blocks should not contain event control statements
  // if they are intended for synthesis.
 endtask

endmodule
