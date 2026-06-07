module STARC05_2_7_4_3_ex1;
 reg a, b;
 initial begin fork #1 a = 1;
 #2 b = 2;
 join end endmodule
