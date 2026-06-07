module star_c05_2_9_2_4_ex2 (clk, reset, out);
 input clk;
 input reset;
 output reg out [3:0];
 integer i;
 always @ (posedge clk or negedge reset) begin
  if (!reset) begin
   for (i = 0; i < 4; i = i + 1) begin
    out[i] = 1'b0;
   end
  end else begin
   for (i = 0; i < 4; i = i + 1) begin
    out[i] = 1'b1;
   end
  end
 end
 endmodule
