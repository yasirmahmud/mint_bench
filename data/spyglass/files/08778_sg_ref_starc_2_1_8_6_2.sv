module st_2_1_8_6_ex2;
 reg global_sig;
 function automatic [7:0] my_func;
 input [7:0] in_val;
 begin my_func = in_val + global_sig;
 end endfunction reg [7:0] result_reg;
 always @(*) begin global_sig = 1'b1;
 result_reg = my_func(8'h01);
 end endmodule
