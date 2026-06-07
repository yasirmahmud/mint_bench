module st_2_1_2_4_ex1();
 reg [7:0] global_var;

 // FIX: Initialize 'global_var' to resolve the 'read but never set' violation (W123).
 // This provides a defined value for the variable, preventing X propagation.
 initial begin
  global_var = 8'd0;
 end

 function automatic [7:0] my_func;
 input [7:0] in_val;
 begin
  my_func = in_val + global_var;
 end
 endfunction
endmodule
