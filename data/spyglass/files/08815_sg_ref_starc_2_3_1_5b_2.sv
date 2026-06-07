module negative_delay_ex2;
 wire a, b;
 assign #(-1) a = b;
 endmodule
