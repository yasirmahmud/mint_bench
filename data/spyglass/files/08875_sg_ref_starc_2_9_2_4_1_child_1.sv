module st_2_9_2_4_ex1 (clk, rst, din, dout);
 input clk, rst, din;
 output reg dout;

 always @ (posedge clk or negedge rst) begin
   if (!rst) begin
     dout = 1'b0;
   end else begin
     dout = din;
   end
 end
endmodule
