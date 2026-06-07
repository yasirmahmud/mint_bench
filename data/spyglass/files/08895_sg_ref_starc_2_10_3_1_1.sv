module st_2_10_3_1_ex1(input [3:0] data_a, input [4:0] data_b, output reg result);
 always @(*) begin if (data_a == data_b) result = 1'b1;
 else result = 1'b0;
 end endmodule
