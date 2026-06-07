module st_2_1_2_4_ex2;
 reg global_sig = 1'b0; // Initialize global_sig to resolve 'never set' violation
 function automatic [7:0] my_func;
 my_func = global_sig + 1;
 endfunction 
endmodule
