module my_module_ex2 (input wire a, output wire b);
 function integer my_func;
 input [1:0] state_in;
 begin if (state_in == 2'b00) begin my_func = 1;
 end end endfunction assign b = my_func(2'b01);
 endmodule
