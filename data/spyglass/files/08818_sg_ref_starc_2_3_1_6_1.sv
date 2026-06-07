module star_2_3_1_6_ex1(input clk, input rst, output reg out);
 always @(posedge clk or posedge rst) begin if (!rst) out <= 1'b0;
 else out <= 1'b1;
 end endmodule
