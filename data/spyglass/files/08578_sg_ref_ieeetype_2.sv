module ieee_type_violation_ex2 (input clk);
 integer my_signal;
 always @(posedge clk) begin my_signal = my_signal + 1;
 end endmodule
