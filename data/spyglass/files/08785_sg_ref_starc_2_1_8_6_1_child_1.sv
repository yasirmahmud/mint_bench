module star_2_1_8_6_ex1 (input a, output b);
 reg global_var = 1'b0;

 function my_func;
  input dummy_in;
  begin
   my_func = dummy_in + global_var;
  end
 endfunction

 assign b = my_func(a);

endmodule
