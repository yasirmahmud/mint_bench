`define MY_MACRO 1
 module W143_ex1;
 initial begin $display("Value: %d", `MY_MACRO);
 end
 `undef MY_MACRO // Resolve WRN_26: Undefine before redefining
 `define MY_MACRO 2
 initial begin $display("New Value: %d", `MY_MACRO);
 end
 endmodule
