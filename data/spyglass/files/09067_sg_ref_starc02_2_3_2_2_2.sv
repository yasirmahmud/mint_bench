module star_c02_2_3_2_2_ex2 (input clk, input d, output reg q1, output reg q2);
 always @(posedge clk) begin q1 <= d;
 q2 = d;
 end endmodule
