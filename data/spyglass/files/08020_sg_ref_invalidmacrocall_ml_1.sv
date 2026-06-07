module InvalidMacroCall_ML_ex1;
 `define MY_MACRO 1;
 reg a;
 initial begin a = ` MY_MACRO;
 end endmodule
