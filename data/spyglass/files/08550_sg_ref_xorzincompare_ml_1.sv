module XOrZInCompare_ex1;
 wire [1:0] a;
 assign a = 2'b1X;
 wire b;
 assign b = (a ==? 2'b10);
 endmodule
