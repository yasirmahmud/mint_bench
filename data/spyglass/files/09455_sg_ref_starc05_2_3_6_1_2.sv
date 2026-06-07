module star_05_2_3_6_1_ex2(input clk, input rst_n, input data_in1, input data_in2, output reg q1, output reg q2);
 always @(posedge clk or negedge rst_n) begin if (!rst_n) begin q1 <= 1'b0;
 end else begin q1 <= data_in1;
 q2 <= data_in2;
 end end endmodule
