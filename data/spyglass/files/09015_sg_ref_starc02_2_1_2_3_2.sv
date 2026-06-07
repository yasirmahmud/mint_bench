module starc02_2_1_2_3_ex2;
 reg [7:0] global_var;
 function integer my_func;
 input [7:0] a;
 begin my_func = a + global_var;
 end endfunction initial begin global_var = 8'd1;
 my_func(8'd2);
 end endmodule
