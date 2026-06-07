module starc05_2_1_10_3_ex1 (input clk, input rst, input in1, input in2, output reg out);
 reg shared_data;
 always @(posedge clk or posedge rst) begin if (rst) shared_data <= 1'b0;
 else if (in1) shared_data <= 1'b1;
 end always @(posedge clk) begin if (in2) shared_data <= 1'b0;
 end assign out = shared_data;
 endmodule
