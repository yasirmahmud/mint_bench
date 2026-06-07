module stac05_2_1_1_2_ex1 (input [1:0] a, output [3:0] b);
 function [3:0] my_func;
 input [1:0] sel_in;
 begin case (sel_in) 2'b00: my_func = 4'd1;
 2'b01: my_func = 4'd2;
 default: ;
 endcase end endfunction assign b = my_func(a);
 endmodule
