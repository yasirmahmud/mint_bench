module starc05_2_10_1_4a_ex1(input [2:0] in_data, output reg out_flag);
 always @(*) begin if (in_data == 3'bxxx) out_flag = 1'b1;
 else out_flag = 1'b0;
 end endmodule
