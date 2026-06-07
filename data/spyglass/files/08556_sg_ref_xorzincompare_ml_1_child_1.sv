module XOrZInCompare_ex1;
 wire [1:0] a;
 assign a = 2'b11;
 wire b;
 assign b = (a ==? 2'b10);
 output dummy_out;
 assign dummy_out = b;
 endmodule
