module w481a_ex2();
 reg [3:0] i;
 reg [3:0] j;
 initial begin i = 0;
 j = 0;
 for (i = 0; j < 4; i = i + 1) begin j = j + 1;
 end end endmodule
