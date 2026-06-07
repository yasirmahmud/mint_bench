module STARC05_2_9_3_1_ex2;
 reg [7:0] my_reg;
 integer i;
 initial begin : loop_block for (i = 0; i < 10; i = i + 1) begin if (i == 5) begin disable loop_block;
 end my_reg = i;
 end end endmodule
