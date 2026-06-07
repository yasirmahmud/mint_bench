module my_module_ex2(input [3:0] in1, input [3:0] in2, input sel, output [4:0] out_val);
 function [4:0] my_adder_func_ex2;
 input [3:0] first;
 input [3:0] second;
 input select;
 begin case (select) 1'b0: my_adder_func_ex2 = first + second;
 default: ;
 endcase end endfunction assign out_val = my_adder_func_ex2(in1, in2, sel);
 endmodule
