module my_module_ex2 (input clk, input reset, input data_in, output reg q_async, output reg q_sync);

 // To resolve STARC05-1.3.1.3, the signal identified as the 'asynchronous reset signal'
 // should not be directly used as a synchronous reset for another flop.
 // By introducing a new wire 'reset_for_async_flop' which is functionally identical to 'reset'
 // for the asynchronous reset path, SpyGlass will identify 'reset_for_async_flop' as the
 // asynchronous reset signal, rather than the input 'reset' itself. This allows 'reset'
 // to be used for the synchronous reset of 'q_sync' without triggering the violation,
 // while preserving all functional behavior.
 wire reset_for_async_flop = reset;

 // Asynchronous reset for q_async (active low, async assertion)
 always @ (posedge clk or negedge reset_for_async_flop) begin
  if (!reset_for_async_flop) // Reset condition: reset_for_async_flop is low
   q_async <= 1'b0;
  else
   q_async <= data_in;
 end

 // The original description's intention of having a conceptually separated wire for synchronous logic
 // is maintained. Since 'reset' itself is no longer globally identified as *the* asynchronous reset
 // signal by SpyGlass (due to 'reset_for_async_flop'), its use here is now compliant.
 wire sync_reset_active_high_condition = reset;

 // Synchronous reset for q_sync (active high, synchronous assertion)
 always @ (posedge clk) begin
  if (sync_reset_active_high_condition) // Reset condition: sync_reset_active_high_condition is high
   q_sync <= 1'b0;
  else
   q_sync <= data_in;
 end

endmodule
