module st_2_1_2_4_ex1();
 reg global_var;
 function automatic [7:0] my_func;
 input [7:0] in_val;
 begin my_func = in_val + global_var;
 end endfunction endmodule
