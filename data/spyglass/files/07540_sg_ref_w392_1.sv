module w392_ex1(q1,q2,data_in,clk,rst);
input data_in;
input clk;
input rst;
output q1,q2;
reg q1,q2;
always @(posedge clk or posedge rst) begin if (rst) q1 <= 1'b0;
 else q1 <= data_in;
 end always @(posedge clk or negedge rst) begin if (!rst) q2 <= 1'b0;
 else q2 <= data_in;
 end endmodule
