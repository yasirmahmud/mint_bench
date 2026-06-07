module W425_ex2;
 reg global_sig;
 function automatic integer my_func;
 input integer local_in;
 begin my_func = local_in + global_sig;
 end endfunction always @(*) begin global_sig = 1;
 my_func(2);
 end endmodule
