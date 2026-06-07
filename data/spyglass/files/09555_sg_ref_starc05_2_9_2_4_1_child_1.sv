module starc05_2_9_2_4_ex1 (clk, reset, d, q);
 input clk;
 input reset;
 input d;
 output reg q;

 always @ (posedge clk or negedge reset) begin
  if (!reset) begin
   q = 1'b0;
  end else begin
   q = d;
  end
 end
 endmodule
