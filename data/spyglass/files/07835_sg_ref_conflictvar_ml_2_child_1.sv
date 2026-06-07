module conflict_var_ex2(input clk, input rst, input in1, input in2, output reg out);
 reg shared_var;
 always @(posedge clk) begin
   if (rst) begin
     shared_var <= 1'b0;
   end else begin
     shared_var <= in1; // Resolved: 'shared_var' must have a single driver. Chosen 'in1' to drive 'shared_var'.
   end
 end
 // The second always block driving 'shared_var' has been removed to resolve the multiple-driver violation (ConflictVar-ML, W415, sim_race02).
 assign out = shared_var;
 endmodule
