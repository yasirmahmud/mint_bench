module W529_ex1 (input a, output b);
 'ifdef SOME_DEFINE assign b = a;
 'else assign b = ~a;
 'endif endmodule
