module STARC05_2_1_8_6_ex1;
 reg global_sig;
 function automatic [0:0] my_func;
 input [0:0] local_in;
 begin my_func = global_sig & local_in;
 end endfunction endmodule
