module my_module_ex2;
 reg [7:0] global_sig;
 function [7:0] my_func;
 input [7:0] in_val;
 begin global_sig = in_val;
 my_func = in_val + 1;
 end endfunction initial begin my_func(8'd10);
 end endmodule
