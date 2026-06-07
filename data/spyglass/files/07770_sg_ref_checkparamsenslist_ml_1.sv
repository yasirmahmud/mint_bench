module check_param_sens_list_ex1;
 parameter P_TRIG = 1;
 reg r_out;
 always @(P_TRIG) begin r_out = 1'b0;
 end endmodule
