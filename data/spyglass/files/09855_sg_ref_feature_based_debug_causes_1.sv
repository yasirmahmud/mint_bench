module debug_causes_ex1 (input a, output b);
 assign b = a;
 specify (a => b) = 10;
 endspecify endmodule
