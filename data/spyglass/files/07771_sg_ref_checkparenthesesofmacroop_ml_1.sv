`define MY_MACRO 1 + 2 module CheckParenthesesOfMacroOP_ex1;
 wire [3:0] result;
 assign result = `MY_MACRO;
 endmodule
