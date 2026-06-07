module star_2_3_1_6_ex2(input clk, input rst_n, input d, output reg q);
always @(posedge clk or posedge rst_n) begin if (!rst_n) q <= 1'b0;
 else q <= d;
 end endmodule
