module STARC02_2_1_8_9_ex1 (input wire sel, output reg out);
 function integer my_func;
 input wire condition;
 if (condition) begin my_func = 1;
 end endfunction assign out = my_func(sel);
 endmodule
