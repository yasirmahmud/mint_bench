module star_ex2;
 reg global_sig = 1'b0;
 function [1:0] my_func;
 input a;
 begin my_func = a + global_sig;
 end endfunction;
 endmodule
