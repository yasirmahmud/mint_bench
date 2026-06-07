module mod_star_2_9_2_4_ex2 (clk, reset, q_out);
 input clk;
 input reset;
 output [3:0] q_out; // Added to resolve W528 - 'out' being unread
 
 integer i;
 reg out [3:0]; // Array of 4 1-bit registers, consistent with original usage
 
 always @ (posedge clk or negedge reset) begin
   if (!reset) begin // Fix for W442a: top-level async reset condition
     for (i = 0; i < 4; i = i + 1) begin
       out[i] = 1'b0; // Asynchronous reset to 0
     end
   end else begin
     // Synchronous behavior when not in reset
     for (i = 0; i < 4; i = i + 1) begin
       out[i] = 1'b1; // Synchronous update to 1 on posedge clk
     
     end
   end
 end

 assign q_out = out; // Connect internal register array to output port to resolve W528
 
endmodule
