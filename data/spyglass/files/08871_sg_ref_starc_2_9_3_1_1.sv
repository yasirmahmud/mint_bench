module STARC_2_9_3_1_ex1;
 reg [7:0] data;
 integer i;
 initial begin for (i = 0; i < 10; i = i + 1) begin if (i == 5) begin exit;
 end data = i;
 end end endmodule
