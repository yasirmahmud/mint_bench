module param_sens_list_ex2;
 parameter MY_PARAM = 1'b1;
 reg out_reg;
 always @(MY_PARAM) begin out_reg = MY_PARAM;
 end endmodule
