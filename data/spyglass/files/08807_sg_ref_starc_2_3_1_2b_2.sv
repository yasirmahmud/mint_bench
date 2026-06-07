module star_2_3_1_2b_ex2 (input clk, input rst_n, input d, output reg q);
 initial begin q = 1'b0;
 end always @(posedge clk or negedge rst_n) begin if (!rst_n) q <= 1'b0;
 else q <= d;
 end assign q = 1'b0;
 deassign q;
 endmodule
