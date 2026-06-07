module star_2_1_1_2_ex1 (input a, output reg out);
 function integer my_func;
 input b;
 begin if (b == 1'b1) begin my_func = 1;
 end end endfunction assign out = my_func(a);
 endmodule
