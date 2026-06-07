module combinational_loop_ex2 (output out);
 wire a, b;
 assign a = ~b;
 assign b = a;
 assign out = a;
 endmodule
