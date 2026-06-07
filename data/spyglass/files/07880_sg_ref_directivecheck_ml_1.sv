`define MY_MACRO module DirectiveCheck_ML_ex1;
 wire a;
 `ifdef MY_MACRO assign a = 1'b0;
 `endif endmodule
