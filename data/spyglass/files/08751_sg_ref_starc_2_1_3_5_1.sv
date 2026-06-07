module starc_2_1_3_5_ex1;
 reg global_sig;
 function automatic [7:0] my_func (input [7:0] in_val);
 begin global_sig = in_val;
 my_func = in_val + 1;
 end endfunction;
 endmodule
