module missing_pin_function_call_ex2(input in_sig, output out_sig);
 function integer my_func;
 input [7:0] func_in;
 begin my_func = func_in + in_sig;
 end endfunction assign out_sig = my_func(8'd5);
 endmodule
