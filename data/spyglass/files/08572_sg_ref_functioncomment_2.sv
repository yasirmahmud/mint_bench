module my_module_ex2;
 reg [7:0] data;
 function integer my_function;
 input integer a;
 begin my_function = a + 1;
 end endfunction assign data = my_function(5);
 endmodule
