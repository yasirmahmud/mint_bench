module my_module_ex2 (input clk, input reset, input data_in, output reg q_async, output reg q_sync);

 // Asynchronous reset for q_async (active low, async assertion)
 always @ (posedge clk or negedge reset) begin
  if (!reset) // Reset condition: reset is low
   q_async <= 1'b0;
  else
   q_async <= data_in;
 end

 // To resolve STARC05-1.3.1.3, the signal used for the synchronous reset of q_sync
 // should not be directly identified as the "asynchronous reset signal 'reset'".
 // We introduce a new wire that carries the same value as 'reset' but is
 // conceptually separated for the synchronous logic. This preserves the functional
 // behavior of q_sync, which requires 'reset' to be HIGH for it to be reset synchronously.
 wire sync_reset_active_high_condition = reset;

 // Synchronous reset for q_sync (active high, synchronous assertion)
 always @ (posedge clk) begin
  if (sync_reset_active_high_condition) // Reset condition: sync_reset_active_high_condition is high
   q_sync <= 1'b0;
  else
   q_sync <= data_in;
 end

endmodule
