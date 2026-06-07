module STARC02_2_1_2_3_ex1;
 reg global_sig = 1'b0;
 function automatic [0:0] my_func;
 input [0:0] in_val;
 begin my_func = in_val & global_sig;
 end endfunction endmodule
