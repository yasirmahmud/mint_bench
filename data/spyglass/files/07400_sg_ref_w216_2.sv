module w216_ex2;
 integer my_int;
 initial begin my_int = 32'hDEADBEEF;
 my_int[7:0] = 8'hFF;
 end endmodule
