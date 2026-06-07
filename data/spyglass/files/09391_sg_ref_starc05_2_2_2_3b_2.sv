module my_module_ex2;
 reg a;
 initial a = 1'b0;
 always begin #1 a = ~a;
 end endmodule
