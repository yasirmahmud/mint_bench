module star_ex2;
 reg global_sig;
 initial begin
  global_sig = 1'b0;
 end
 function [1:0] my_func;
  input a;
  begin
   my_func = {1'b0, a} + {1'b0, global_sig};
  end
 endfunction;
endmodule
