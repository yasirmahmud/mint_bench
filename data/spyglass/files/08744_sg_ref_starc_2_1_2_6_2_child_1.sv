module star_2_1_2_6_ex2(clk, in_sig, out_sig);
 input clk;
 input in_sig;
 output reg out_sig;

 wire task_output_comb; // Declare a wire to capture the combinatorial output of the task

 always @(posedge clk) begin
  // Call the task with the current 'in_sig'.
  // The task will combinatorially assign 'in_sig' to 'task_output_comb' at this clock edge.
  my_task(in_sig, task_output_comb);
  // Register the combinatorial output into 'out_sig' at the positive edge of 'clk'.
  // This implements the one-cycle delay observed in the original code.
  out_sig <= task_output_comb;
 end

 task my_task;
 input t_in;
 output t_out;
 begin
  // Removed the event control statement '@(posedge clk)' to resolve SYNTH_196 violation.
  // The task is now purely combinatorial.
  t_out = t_in;
 end
 endtask

endmodule
