module my_module_ex2(input [1:0] sel, output reg [3:0] out);
 function [3:0] my_func_ex2;
 input [1:0] f_sel;
 begin case (f_sel) 2'b00: my_func_ex2 = 4'hA;
 2'b01: my_func_ex2 = 4'hB;
 default: ;
 endcase end endfunction assign out = my_func_ex2(sel);
 endmodule
