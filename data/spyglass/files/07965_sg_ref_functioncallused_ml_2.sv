module my_module_ex2;
 function integer func_inner;
 input integer a;
 begin func_inner = a + 1;
 end endfunction function integer func_outer;
 input integer b;
 integer result;
 begin result = func_inner(b);
 func_outer = result * 2;
 end endfunction initial begin integer x;
 x = func_outer(5);
 end endmodule
