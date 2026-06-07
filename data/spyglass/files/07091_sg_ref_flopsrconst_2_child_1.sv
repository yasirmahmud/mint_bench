module flop_sr_const_ex2 (input clk, input d, output reg q);
 wire rst_n; // Declare rst_n
 always @(posedge clk or negedge rst_n) begin
  if (!rst_n) q <= 1'b0;
  else q <= d;
 end
 assign rst_n = 1'b0;
endmodule
