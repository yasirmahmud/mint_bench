module star_3_1_3_4b_ex1 (input clk);
 wire rst;
 assign rst = 1'b0;

 reg dummy_reg;

 always @(posedge clk) begin
  if (!rst) begin // Active-low synchronous reset
   dummy_reg <= 1'b0;
  end else begin
   // Since 'rst' is constantly 0, the 'else' branch is never taken.
   // This assignment simply completes the sequential block, 
   // but does not affect the functional behavior of 'dummy_reg',
   // which will always be reset to 0.
   dummy_reg <= 1'b0;
  end
 end

 endmodule
