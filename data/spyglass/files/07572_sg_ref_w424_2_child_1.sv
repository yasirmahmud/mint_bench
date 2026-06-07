module W424_ex2;
 output reg global_var; // Declared as output to resolve W528 (variable set but not read)

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
