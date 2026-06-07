module DisallowForceOnEquiNet_ex2;
 wire w1;
 wire w2;
 assign w2 = w1;
 initial begin force w1 = 1'b1;
 force w2 = 1'b0;
 end endmodule
