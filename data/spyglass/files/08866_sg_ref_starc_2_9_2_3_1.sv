module STARC_2_9_2_3_ex1 (input [7:0] data_in, output reg out_flag);
 integer i;
 always @(*) begin out_flag = 1'b0;
 for (i = 0; i <= 100; i = i + 1) begin if (data_in[i%8]) begin out_flag = 1'b1;
 end end end endmodule
