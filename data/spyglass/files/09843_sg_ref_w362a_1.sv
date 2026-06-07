module w362a_ex1(input clk, input rst, input [1:0] s, output reg o1);
 reg [2:0] d;
 always @(posedge clk or negedge rst) begin if (!rst) d <= 3'b0;
 else d <= d + 1'b1;
 end always @(*) begin if (d == s) o1 = 1'b1;
 else o1 = 1'b0;
 end endmodule
