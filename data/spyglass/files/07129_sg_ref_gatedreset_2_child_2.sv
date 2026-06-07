module gated_reset_latch_ex2 (input enable_i, input rst_i, input gating_sig_i, input data_i, output reg q_o);
 wire gated_rst;
 assign gated_rst = rst_i & gating_sig_i; // Defines the gated reset logic

 // Use always @* for combinational logic. 
 // When an output is not assigned under all conditions, a latch is inferred.
 // This avoids the combinational loop and sensitivity list issues.
 always @* begin
   if (gated_rst) begin // Asynchronous clear for the latch
     q_o = 1'b0; // Use blocking assignment for combinational logic
   end else if (enable_i) begin // If not reset and enable is high
     q_o = data_i; // Data is passed through
   end
   // If gated_rst is low AND enable_i is low, q_o is not explicitly assigned.
   // This implicitly infers a latch, causing q_o to hold its previous value,
   // thus preserving the original functional behavior.
 end
endmodule
