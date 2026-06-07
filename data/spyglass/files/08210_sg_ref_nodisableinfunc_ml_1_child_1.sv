module my_module_ex1(input a, output reg b);
 function automatic [7:0] my_function(input [7:0] data);
 begin
 my_function = data + 1;
 end
 endfunction

 initial begin
 b = my_function(a);
 end
endmodule
