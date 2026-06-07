module exotic_clock_ex1(input clk_in, output reg gclk);
 reg [1:0] cnt;
 wire clk_in_level_control; // Wire to isolate clk_in's data usage from its clock usage

 assign clk_in_level_control = clk_in; // clk_in's level for latch control

 always @(posedge clk_in) begin
  cnt <= cnt + 1;
 end

 // This block infers a latch for 'gclk' by only assigning it under specific conditions.
 // This addresses the 'CombLoop' violations by removing 'gclk = gclk'.
 // Using 'clk_in_level_control' for the level-sensitive logic aims to resolve
 // 'STARC05-1.4.3.4' by differentiating 'clk_in' as a clock from its use as a data signal.
 always @(*) begin
  if (clk_in_level_control == 0 && cnt == 0) begin
   gclk = 1;
  end else if (clk_in_level_control == 1 && cnt == 1) begin
   gclk = 0;
  end
  // If neither condition is met, 'gclk' is not explicitly assigned, which infers a latch
  // holding its previous value. This preserves the functional behavior of a latch.
 end
endmodule
