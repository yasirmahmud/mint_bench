module starc05_2_9_1_2a_ex2(input [3:0] non_const_start, output reg [3:0] result);
 integer i;
 always @(*) begin result = 4'b0;
 for (i = non_const_start; i < 4'd5; i = i + 1) begin result = i;
 end end endmodule
