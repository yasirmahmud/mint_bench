module W424_ex2(output reg global_var); // global_var declared as output port to resolve STX_VE_648 and maintain W528 fix intent

 // Modified function: it now returns a value instead of setting a global variable (resolves W424)
 function reg [0:0] my_func;
  input dummy_in;
  begin
   return dummy_in;
  end
 endfunction

 initial begin
  // Assign the return value of the function to global_var
  global_var = my_func(1'b0);
 end

endmodule
