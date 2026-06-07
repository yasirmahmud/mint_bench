module my_module_ex1;
 function integer my_func;
 input integer a;
 begin if (a > 0) begin my_func = a + 1;
 return;
 $display("This statement is ignored.");
 end else begin my_func = 0;
 end end endfunction endmodule
