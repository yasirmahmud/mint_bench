module star_ex1;
 reg global_sig;
 function integer my_func;
 input [7:0] in_val;
 begin global_sig = in_val[0];
 my_func = in_val[1];
 end endfunction initial begin my_func(8'hFF);
 end endmodule
