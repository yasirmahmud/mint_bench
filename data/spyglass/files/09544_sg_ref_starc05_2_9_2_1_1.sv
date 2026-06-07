module STARC05_2_9_2_1_ex1;
 reg [7:0] data;
 reg [7:0] result;
 integer i;
 initial begin data = 8'd10;
 for (i = 0; i < 8; i = i + 1) result = data + i;
 end endmodule
