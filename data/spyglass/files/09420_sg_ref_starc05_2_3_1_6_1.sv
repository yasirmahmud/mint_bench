module star_c05_2_3_1_6_ex1 (input clk, input rst, output reg q);
 always @(posedge clk or posedge rst) begin if (!rst) begin q <= 1'b0;
 end else begin q <= ~q;
 end end endmodule
