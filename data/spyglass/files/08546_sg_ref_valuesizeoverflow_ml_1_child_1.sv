module ValueSizeOverFlow_ML_ex1;
 function void my_check_func;
 input [32:0] arg_int; // Changed from 'integer' to '[32:0]' to accommodate 33-bit value
 begin 
  // Original behavior of function body is preserved (empty)
 end 
 endfunction 
 initial begin 
  my_check_func(33'h1_0000_0000);
 end 
 endmodule
