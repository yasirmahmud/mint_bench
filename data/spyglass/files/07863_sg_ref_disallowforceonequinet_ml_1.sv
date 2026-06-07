module disallow_force_equi_net_ex1;
 wire w1;
 wire w2;
 assign w2 = w1;
 initial begin force w1 = 1'b0;
 force w2 = 1'b1;
 #10 release w1;
 release w2;
 end endmodule
