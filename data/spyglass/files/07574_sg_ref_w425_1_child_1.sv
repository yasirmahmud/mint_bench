module W425_ex1;
 reg global_var;
 function integer my_func;
 input dummy_in;
 input reg_value; // Added input to pass the value of global_var
 begin
 my_func = reg_value ? 1 : 0; // Use the input instead of accessing global_var directly
 end
 endfunction 
 initial begin
 global_var = 1'b1;
 $display("Result: %0d", my_func(0, global_var)); // Pass global_var's value to the function
 end
 endmodule
