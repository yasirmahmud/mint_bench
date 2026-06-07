module stac05_2_9_2_3_ex2 (input [15:0] in_data, output reg out_flag);
 integer i;
 always @(*) begin out_flag = 1'b0;
 for (i = 0; i <= 100; i = i + 1) begin if (in_data[i%16] == 1'b1) begin out_flag = 1'b1;
 end end end endmodule
