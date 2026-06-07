module my_module_ex1;
 reg global_sig;

 // Fix W123: Variable 'global_sig' read but never set.
 // Initialize global_sig to a default value.
 initial begin
  global_sig = 1'b0;
 end

 function automatic [7:0] my_function;
 begin
  // Fix W416: Return type width '8' is greater than return value width '1'.
  // Explicitly zero-extend global_sig to match the 8-bit return type
  // of my_function, preserving the implicit Verilog behavior.
  my_function = {7'b0, global_sig};
 end
 endfunction
endmodule
