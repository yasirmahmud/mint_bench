module starc_2_9_1_2b_ex1;
 reg [3:0] non_constant_limit;
 reg [3:0] i;
 initial begin non_constant_limit = 5;
 for (i = 0; i < non_constant_limit; i = i + 1) ;
 end endmodule
