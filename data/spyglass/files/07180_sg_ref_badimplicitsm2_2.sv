module badimplicitSM2_ex2(input clk,input rst,input in,output reg q);
always @(posedge clk or posedge rst) begin if(rst) q<=1'b0;
 else q<=in;
 end always @(negedge clk) begin if(in) q<=~q;
 end endmodule
