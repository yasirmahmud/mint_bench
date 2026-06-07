module starc05_2_9_1_2b_ex2;
 reg [7:0] i;
 reg [7:0] limit_reg;
 initial begin limit_reg = 5;
 for (i = 0; i < limit_reg; i = i + 1) begin end end endmodule
