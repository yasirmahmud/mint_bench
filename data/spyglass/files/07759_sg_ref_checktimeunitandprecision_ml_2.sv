module my_module_ex2;
 reg r;
 initial begin #1 r = 1'b0;
 #2 r = 1'b1;
 end endmodule
